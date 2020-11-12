class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).order("product_name").page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end
end
