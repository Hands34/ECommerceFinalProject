class HomeController < ApplicationController
  def index
    @products = Product.includes(:category)
                       .order("product_name")
                       .limit(7)

    @categories = Category.all

    # @companies = Company.all
  end
end
