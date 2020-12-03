class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :initialize_session
  before_action :set_breadcrumbs
  helper_method :cart
  helper_method :categories_for_select
  helper_method :provinces_for_select

  def add_breadcrumb(label, path = nil)
    @breadcrumbs << {
      label: label,
      path:  path
    }
  end

  def set_breadcrumbs
    @breadcrumbs = []
  end

  def categories_for_select
    categories = [Category.new(category_name: "All", id: -99), *Category.all]
  end

  def provinces_for_select
    provinces = [*Province.all]
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
