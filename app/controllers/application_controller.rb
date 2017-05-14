class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  # protect_from_forgery with: :exception
  before_action :initialize_omniauth_state

  def authenticate!
    redirect_to '/login' unless current_user.present?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  protected
  def initialize_omniauth_state
    session['omniauth.state'] = response.headers['X-CSRF-Token'] = form_authenticity_token
  end
end
