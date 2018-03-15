module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController

    def sign_up_params
      params.permit(%i[email password password_confirmation name first_name last_name password_confirmation profile_pic])
    end

    def create
      parameters = sign_up_params.dup
      parameters.delete(:profile_pic)
      @resource = resource_class.new(parameters)
      @resource.uid        = sign_up_params[:email]
      @resource.provider   = 'email'

      # success redirect url is required
      unless params[:confirm_success_url]
        return render json: {
            status: 'error',
            data:   @resource,
            errors: ['Missing `confirm_success_url` param.']
        }, status: 403
      end

      begin
        # override email confirmation, must be sent manually from ctrl
        @resource.class.skip_callback('create', :after, :send_on_create_confirmation_instructions)
        if @resource.save

          @resource.save_profile_pics(sign_up_params)

          if @resource.confirmed?
            # email auth has been bypassed, authenticate user
            @client_id = SecureRandom.urlsafe_base64(nil, false)
            @token     = SecureRandom.urlsafe_base64(nil, false)

            @resource.tokens[@client_id] = {
                token: BCrypt::Password.create(@token),
                expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
            }

            @resource.save!

            update_auth_header
          else
            # user will require email authentication
            @resource.send_confirmation_instructions(client_config: params[:config_name],
                                                         redirect_url: params[:confirm_success_url])

          end
        else
          clean_up_passwords @resource
          render json: {
              status: 'error',
              data:   @resource,
              errors: @resource.errors.to_hash.merge(full_messages: @resource.errors.full_messages)
          }, status: 403
        end
      rescue Mongoid::Errors::MongoidError
        clean_up_passwords @resource
        render json: {
            status: 'error',
            data:   @resource,
            errors: ["An account already exists for #{@resource.email}"]
        }, status: 403
      end
    end
  end
end