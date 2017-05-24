class ProductsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show,:add_to_cart, :add_to_favorite, :quit_favorite]
  before_action :validates_search_key, only:[:search]
  before_action :find_product, only:[:show, :add_to_cart, :add_to_favorite, :quit_favorite, :pay_now]
  def index
    @products = Product.all
    if params[:favorite] == "yes"
      @products = current_user.products
    end
    case params[:category]
    when "餐"
      @products = Product.all.where(:category => "餐")
    when "茶"
      @products = Product.all.where(:category => "茶")
    when "酒"
      @products = Product.all.where(:category => "酒")
    when "花"
      @products = Product.all.where(:category => "花")
    when "香"
      @products = Product.all.where(:category => "香")
    end

    case params[:order]
    when "latest"
      @products = Product.includes(:photos).recent
    when "price"
      @products = Product.includes(:photos).order("price DESC")
    when "hot"
      @products = Product.includes(:photos).sort_by{|product|  product.users.count}.reverse
    end
  end

  def show
    @review = Review.new
    @photos = @product.photos.all
  end

  def add_to_cart
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将#{@product.title}加入购物车!"
    else
      flash[:notice] = "你的购物车内已有此物品！"
    end
  end

  def add_to_favorite
    if current_user
      @product.add_to_favorite!(current_user)
    else
      flash[:alert] = "亲，你要先登录哦！"
    end
  end

  def quit_favorite
    if current_user
      @product.quit_favorite!(current_user)
      render "add_to_favorite"
    else
      flash[:alert] = "亲，你要先登录哦！"
    end
  end

  def search

    @products = Product.ransack({:title_or_description_cont => @q}).result(distinct: true)
  end
  def pay_now
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
    else
      flash[:warning] = "购物车已有此商品!"
    end
    redirect_to carts_path
  end
  protected

  def validates_search_key
    @q = params[:query_string].gsub(/\\|\'|\/|\?/, "") if params[:query_string].present?
  end

end
