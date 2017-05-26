class CartItemsController < ApplicationController

  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    if @cart_item.product.quantity >= cart_item_params[:quantity].to_i
      @cart_item.update(cart_item_params)
      flash[:notice] = "成功变更数量 "
    else
      flash[:warning] = "数量不足以加入购物车"
    end
    redirect_to carts_path
  end
  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
  end

  def reduce_quantity
    @cart_item = CartItem.find(params[:id])
    if @cart_item.quantity > 0
      @cart_item.quantity -= 1
    else
      flash[:warning] = "亲，已经没的减啦！"
    end
    @cart_item.save
  end

  def add_quantity
    @cart_item = CartItem.find(params[:id])
    if @cart_item.quantity < @cart_item.product.quantity
     @cart_item.quantity += 1
      @cart_item.save
    else
      flash[:warning] = "库存不足，不能再加啦！"
    end
    render "reduce_quantity"
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

end
