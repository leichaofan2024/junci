class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def require_is_admin
    if !current_user.admin?
      redirect_to "/"
    end
  end

  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end


  protected

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    if cart.blank?
      Cart.create
    end
    session[:cart_id] = cart.id
    return cart
  end
  

  def find_product
    @product = Product.find(params[:id])
  end
end
