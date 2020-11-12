class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).order("product_name").page(params[:page])
  end
  # def index
  #   @products = Product.search(params[:search]).page(params[:page])
  # end

  def show
    @product = Product.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    category_search = params[:category_id].to_i
    if category_search == -99
      @products = Product.where("product_name LIKE ?", wildcard_search)
    else
      @products = Product.where("product_name LIKE ?", wildcard_search).where("category_id == ?", category_search)
    end
  end
end
