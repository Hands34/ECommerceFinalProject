class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    add_breadcrumb("Categories")
  end

  def show
    @category = Category.find(params[:id])
    add_breadcrumb("Categories", categories_path)
    add_breadcrumb(@category.category_name)
  end
end
