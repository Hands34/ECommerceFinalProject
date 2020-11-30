class CheckoutController < ApplicationController
  # POST /checkout/create
  # A product id will be in the params hash: params[:product_id]
  def create
    # Establish a connection with Stripe and then redirect user to the payment screen.

    line_items = session[:shopping_cart].map do |cart_item|
      product = Product.find(cart_item)
      {
        name:        product.product_name,
        description: product.description,
        amount:      product.price,
        currency:    "cad",
        quantity:    1
      }
    end

    # establish a connection to Stripe using the stripe gem

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           line_items
    )

    respond_to do |format|
      format.js # render app/views/checkout/create.js.erb
    end
  end

  def success
    # We took the customers money
  end

  def cancel
    # Something went wrong with the payment.
  end
end
