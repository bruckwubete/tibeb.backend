class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Error::ErrorHandler
  wrap_parameters false
  
  #Rescue From Errors
  rescue_from ActionController::ParameterMissing, :with => :error_param_missing
  
  @@API_VERSION = 'v1'
  
  
  
  private
  
  def error_param_missing(e)
    @message = e.message
    @status = 400
    respond_to do |type|
      type.json {render template: "api/#{@@API_VERSION}/errors/error_400", status: @status}
    end
  end
end
