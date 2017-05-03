class SessionsController < ApplicationController
  around_action :handle_exceptions, only: [:create, :destroy]

  def new
  end

  def create
    params.require(:email)
    params.require(:password)
    user = User.find_by(email: params[:email])

    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id

      redirect_path = user.admin? ? admin_root_path : root_path
      flash[:success] =  'User was successfully created.'

      redirect_to redirect_path
    else
      # If user's login doesn't work, send them back to the login form.
      flash[:error] =  'User not found.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private
  def handle_exceptions
    begin
      yield
    rescue => e
      flash[:error] =  'Error: #{e.message}'
      redirect_to login_path
    end
  end
end
