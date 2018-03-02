module Overrides
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
    def validate_token
      # @resource will have been set by set_user_token concern
      unless @resource
        render json: {
            success: false,
            errors: ['Invalid login credentials']
        }, status: 401
      end
    end
  end
end