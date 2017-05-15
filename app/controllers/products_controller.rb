class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product,only:[:show,:edit,:update,:destroy]
  def index
    @products = Product.all
  end

  def show
  end




end
