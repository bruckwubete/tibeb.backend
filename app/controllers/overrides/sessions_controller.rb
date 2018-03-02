module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController

    def create
      # honor devise configuration for case_insensitive_keys
      email = if resource_class.case_insensitive_keys.include?(:email)
                resource_params[:email].downcase
              else
                resource_params[:email]
              end

      @resource = resource_class.where(uid: email, provider: 'email').first

      if @resource && valid_params? && @resource.valid_password?(resource_params[:password]) && @resource.confirmed?
        # create client id
        @client_id = SecureRandom.urlsafe_base64(nil, false)
        @token     = SecureRandom.urlsafe_base64(nil, false)

        @resource.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
        }
        @resource.save

        sign_in(:user, @resource, store: false, bypass: false)

      elsif @resource && !@resource.confirmed?
        render json: {
          success: false,
          errors: [
            "A confirmation email was sent to your account at #{@resource.email}. " \
            'You must follow the instructions in the email before your account ' \
            'can be activated'
          ]
        }, status: 401

      else
        render json: {
          errors: ['Invalid login credentials. Please try again.']
        }, status: 401
      end
    end
  end
end
