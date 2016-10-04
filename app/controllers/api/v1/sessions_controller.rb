module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.from_omniauth(env["omniauth.auth"])
        session[:user_id] = user.id
        redirect_to '/auth/facebook', :notice => "Signed in!"
      end

      def new
        redirect_to '/auth/facebook'
      end

      def failure
        redirect_to '/auth/facebook', :alert => "Authentication error: #{params[:message].humanize}"
      end

      def destroy
        reset_session
        redirect_to 'auth/facebook', :notice => 'Signed out!'
      end
    end
  end
end
