class SessionsController < Api::V1::ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to '/', notice: "Signed in!"
  end

  def new
    current_user 
  end

  def failure
    redirect_to '/signin', alert: "Authentication error: #{params[:message].humanize}"
  end

  def destroy
    reset_session
    redirect_to '/signin', notice: 'Signed out!'
  end
end
