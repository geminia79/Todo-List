class OauthController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      @message =  "You are successfully logged in!"
      flash[:success] = "You are successfully logged in!"
    rescue OmniAuth::Strategies::OAuth2::CallbackError => e
      flash[:error] = "Issue with logging user in, Please authorize Application to sign in."
    rescue =>  e
      @message =  "Error: #{e.message}"
      flash[:error] = "There was error with login. #{e.message}"
    end
    redirect_to root_path
  end
end
