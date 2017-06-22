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

  def show
    @product = Product.find_by_friendly_id!(params[:id])
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
    @product = Product.find_by_friendly_id!(params[:id])
  end

  def update
    @product = Product.find_by_friendly_id!(params[:id])
    if params[:photos] != nil
      @product.photos.destroy_all

      params[:photos]["avatar"].each do |a|
        @picture = @product.photos.create(:avatar => a)
      end

      @product.update(product_params)
      redirect_to admin_products_path, notice: "更新成功!"
    elsif @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end
  def destroy
    @product = Product.find_by_friendly_id!(params[:id])
    @product.destroy
  redirect_to admin_products_path, alert: "删除成功！"
end

  private



  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :category, :friendly_id)
  end

end
