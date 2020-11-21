class ApplicationController < ActionController::Base
  before_action :initialize_session
  # before_action :add_breadcrumb
  helper_method :cart
  helper_method :categories_for_select

  def categories_for_select
    categories = [Category.new(category_name: "All", id: -99), *Category.all]
  end

  private

  def initialize_session
    session[:shopping_cart] ||= [] # The shopping cart will be an array of product ids.
  end

  def cart
    # Return a collection of Product objects based on the product ids in the shopping cart.
    Product.find(session[:shopping_cart])
  end
end
