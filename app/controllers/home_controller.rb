class HomeController < ApplicationController
  def index
    @products = get_products
  end
  private
  def get_products
    @search = Product.ransack(params[:q])
    # user_id = params[:user_id] || current_user.id
    @search.result.includes(:user).all
  end
end
