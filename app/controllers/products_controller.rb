class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product,only:[:show,:edit,:update,:destroy,:add_to_cart]
  def index
    @products = Product.all
  end

  def show
  end

  def add_to_cart
    if @product.quantity.present? && @product.quantity > 0
      unless current_cart.products.include?(@product)
        current_cart.add_product_to_cart(@product)
        flash[:notice] = "成功加入购物车！"
      else
        flash[:alert] = "购物车已有此商品!"
      end
    else
      flash[:alert] = "商品#{@product.title}销售一空，无法购买"
    end
      redirect_to :back
  end



end
