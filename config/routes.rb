Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions      => "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords",
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root "welcome#index"
  namespace :account do
    resources :orders
  end

  namespace :admin do
    resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end
  resources :products do
    resources :reviews
    collection do
      get :search
    end

    member do
      post :add_to_cart
      post :pay_now
      post :add_to_favorite
      post :quit_favorite
    end
  end
  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end
  resources :cart_items do
    member do
      post :reduce_quantity
      post :add_quantity
    end
  end
  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

end
