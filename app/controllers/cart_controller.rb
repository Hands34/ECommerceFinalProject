class CartController < ApplicationController
  # POST /cart
  # Add params[:id] product to the cart
  def create
    id = params[:id].to_i
    unless session[:shopping_cart].include?(id)
      session[:shopping_cart] << id
      flash[:notice] = "Added Item to Cart."
    end
    redirect_to root_path
  end
  # Automagically load the associated view: app/cart/create.html.erb

  # DELETE /cart/:id
  # Remove product from the cart
  def destroy
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    flash[:delete_notice] = "Removed Item from Cart."
    redirect_to root_path
  end
end
