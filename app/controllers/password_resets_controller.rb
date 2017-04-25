class PasswordResetsController < ApplicationController
  around_action :handle_exceptions

  def new
  end

  def create
    params.require(:email)

    user = User.find_by(email: params[:email])
    user.send_reset_password_instructions if user.present?

    redirect_to root_path, notice: "Email with password reset instructions sent."
  end

  def edit
    params.require(:id)
    @user = User.find_by!(reset_password_token: params[:id])
  end

  def update

    @user = User.find_by!(reset_password_token: params[:id])
    if @user.within_reset_password_period?
      redirect_to new_passsword_reset_path, error: "Password Reset has expired."
    else
      if @user.update(password: params[:user][:password], reset_password_sent_at: nil, reset_password_token: nil)
        UserMailer.password_reset_success(@user).deliver_now
        redirect_to root_path, notice: "Password has been reset successfully."
      else
        puts "errors: #{@user.errors.full_messages}"
        flash[:error] = "Some Error prohibited password_reset: #{@user.errors.full_messages}"
        render :edit
      end
    end
  end

  private
  def handle_exceptions
    begin
      yield
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Password Reset link expired or is invalid."
      redirect_to login_path
    rescue => e
      flash[:error] = "Internal Error: #{e.message}"
      redirect_to login_path
    end
  end
end
