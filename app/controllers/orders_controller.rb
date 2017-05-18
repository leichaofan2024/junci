class OrdersController < ApplicationController


  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.tatal_price
    if @order.save
      current_cart.cart_items.each do |cart_item|
        product_list = ProductList.new
        producdt.order = @order 
        product_list.product_name = cart_item.product.title
        product_list.product_price = cart_item.product.price
        product_list.quantity = cart_item.quantity
        proudct_list.save
      end
      current_cart.cart_items.destroy_all
      redirect_to order_path(@order)
    else
      render 'carts/checkout'
    end
  end

  protected

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address)
  end

end
