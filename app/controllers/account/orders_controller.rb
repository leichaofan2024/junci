class Account::OrdersController < ApplicationController

  def index
    @orders = current_user.orders.order("created_at DESC")
    if params[:status] == "paid"
      @orders = @orders.where(:is_paid => true)
    end
    if params[:status] == "unpaid"
      @orders = @orders.where(:is_paid => false)
    end
  endd

end
