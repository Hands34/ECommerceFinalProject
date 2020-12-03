class CheckoutController < ApplicationController
  # POST /checkout/create
  # before_action :authenticate_user!
  # A product id will be in the params hash: params[:product_id]
  def create
    # Establish a connection with Stripe and then redirect user to the payment screen.
    prov_id = params[:province_id]
    province = Province.find(prov_id)

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
    sum = session[:shopping_cart].sum { |id| Product.find(id).price }
    logger.debug("Sum is #{sum}")

    line_items << {
      name:     "HST",
      amount:   sum * province.tax_rate / 100,
      currency: "cad",
      quantity: 1

    }

    # establish a connection to Stripe using the stripe gem

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           line_items
    )

    new_order = current_user.orders.create(total_price: sum, tax: sum * province.tax_rate,
      status: "Incomplete", payment_id: @session.id)
    logger.debug(new_order.errors.messages)

    # new_order.

    respond_to do |format|
      format.js # render app/views/checkout/create.js.erb
    end
  end

  def success
    # We took the customers money
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    # new_order.status = "Completed" if @payment_intent == "paid"
  end

  def cancel
    # Something went wrong with the payment.
  end

  def invoice
    @province = Province.all
  end
end
