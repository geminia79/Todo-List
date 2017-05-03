class OauthController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      @message =  "You are successfully logged in!"
      flash[:success] = "You are successfully logged in!"
      redirect_path = @user.admin? ? admin_root_path : root_path
    rescue OmniAuth::Strategies::OAuth2::CallbackError => e
      flash[:error] = "Issue with logging user in, Please authorize Application to sign in."
      redirect_path = sign_in_path
    rescue =>  e
      @message =  "Error: #{e.message}"
      flash[:error] = "There was error with login. #{e.message}"
      redirect_path = sign_in_path
    end

    redirect_to redirect_path
  end

  def failure
    flash[:error] = 'Issue with logging user in, Please authorize Application to sign in.'
    redirect_to login_path
  end
end
