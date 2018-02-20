class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include DeviseTokenAuth::Concerns::SetUserByToken
  wrap_parameters false

  # rescue errors
  rescue_from ::ActionController::RoutingError, with: :error_occurred
  rescue_from Mongoid::Errors::Validations, with: :handle_validation_error

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name]
  end

  def error_occurred(exception)
    render json: { error: exception.message }.to_json, status: 500
  end

  def handle_validation_error(exception)
    render template: 'api/v1/errors/email_already_inuse'
  end
end
