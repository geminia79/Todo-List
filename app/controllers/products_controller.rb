class ProductsController < ApplicationController
  before_action :authenticate!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = get_products
  end

  def show
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def get_products
      @search = Product.ransack(params[:q])
      user_id = params[:user_id] || current_user.id
      @search.result.includes(:user).all
    end

    def product_params
      params.require(:product).permit(:name, :price, :user_id, :product_image)
    end
end
