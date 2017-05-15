class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def require_is_admin
    if !current_user.admin?
      redirect_to "/"
    end
  end

  protected
  
  def find_product
    @product = Product.find(params[:id])
  end
end
