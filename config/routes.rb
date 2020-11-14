Rails.application.routes.draw do
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
  resources :searches
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
