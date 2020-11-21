class HomeController < ApplicationController
  def index
    @products = Product.includes(:category)
                       .order("product_name")
                       .limit(7)

    @categories = Category.all

    # @companies = Company.all
  end

  # def add_breadcrumb
  #   add_breadcrumb "Home", :root_path
  # end
end
