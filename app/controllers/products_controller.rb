class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product,only:[:show,:edit,:update,:destroy,:add_to_cart]
  def index
    @products = Product.all
  end

  def show
  end

  def add_to_cart
    
  end



end
