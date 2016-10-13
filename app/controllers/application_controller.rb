
    class ApplicationController < ActionController::Base
 protect_from_forgery with: :null_session
  include DeviseTokenAuth::Concerns::SetUserByToken
  wrap_parameters false
 
    # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :null_session

  rescue_from ActionController::RoutingError, with: :error_occurred
  rescue_from ActionController::UnknownController, with: :error_occurred
  rescue_from Exception, with: :error_occurred
  rescue_from NameError, with: :error_occurred

  # protected

  def error_occurred(exception)
    render json: {error: exception.message}, status: 500
    return
  end

  def not_found
    render json: {error: true}
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name]
  end
    end
