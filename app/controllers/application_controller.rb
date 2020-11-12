class ApplicationController < ActionController::Base
  helper_method :categories_for_select

  def categories_for_select
    categories = [Category.new(category_name: "All", id: -99), *Category.all]
  end
end
