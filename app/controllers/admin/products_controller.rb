class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  layout "admin"
  before_action :require_is_admin
  before_action :find_product, only: [:edit, :update, :destroy ]
  def index
    @products= Product.all
  end

  def new
    @product = Product.new
    @photo = @product.photos.build
  end
  def create
    @product = Product.new(product_params)
    if @product.save
      if params[:photos] != nil
        params[:photos]["avatar"].each do |a|
          @photo = @product.photos.create(:avatar => a)
        end
      end
      redirect_to admin_products_path，notice: "成功新增产品！"
    else
      render :new
    end
  end

  def edit
  end
  def update
    if @product.update(product_params)
      redirect_to admin_products_path,notice: "更新成功！"
    else
      render :edit
    end
  end


  private



  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :category)
  end

end
