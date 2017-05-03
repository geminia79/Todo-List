class Admin::AdminController < ApplicationController
  before_action :authenticate_admin!

  private
  def authenticate_admin!
    redirect_to '/login' unless current_user.present? && current_user.admin?
  end
end
