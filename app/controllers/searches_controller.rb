class SearchesController < ApplicationController
  def show
    @search = Search.find(params[:id])
  end

  def new
    @search = Search.new
    @categories_search = Category.distinct.pluck(:category_name)
    @companies_search = Product.distinct.pluck(:company)
  end

  def create
    @search = Search.create(search_params)
    redirect_to @search
  end

  private

  def search_params
    params.require(:search).permit(:product_name, :category_id, :company)
  end
end
