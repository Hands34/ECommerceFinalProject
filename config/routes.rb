Rails.application.routes.draw do
  get 'home/index'
  # get 'categories/index'
  # get 'categories/show'
  # get 'products/index'
  # get 'products/show'
  resources :products, only: %i[index show]
  resources :categories, only: %i[index show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
