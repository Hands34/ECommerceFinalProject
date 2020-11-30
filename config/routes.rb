Rails.application.routes.draw do
  scope "/checkout" do
    get "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end

  devise_for :users
  get "contact/index"
  get "about/index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "home/index"
  # get 'categories/index'
  # get 'categories/show'
  # get 'products/index'
  # get 'products/show'
  resources :products, only: %i[index show] do
    collection do
      get "search"
    end
  end
  resources :categories, only: %i[index show]
  resources :cart, only: %i[create destroy]
  resources :searches
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
