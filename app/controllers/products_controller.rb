class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).order("product_name").page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    @products = Product.where("product_name LIKE ?", wildcard_search)
  end
end
