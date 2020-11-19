class CartController < ApplicationController
  # POST /cart
  # Add params[:id] product to the cart
  def create
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to root_path
  end
  # Automagically load the associated view: app/cart/create.html.erb

  # DELETE /cart/:id
  # Remove product from the cart
  def destroy
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to root_path
  end
end
