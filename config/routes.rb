Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  resources :products
  resources :carts, only: [:show] do
    delete 'destroy_all', to: 'cart_items#destroy_all'
  end

  resources :cart_items, only: [:create, :update, :destroy] do
    collection do
      post 'order'
    end
  end
  
  # Routes for PurchaseHistoriesController
  resources :purchase_histories, only: [:index]

  # Route for retrieving purchase history for a specific user
  get 'purchase_histories/:user_id', to: 'purchase_histories#index', as: 'user_purchase_histories'

  get '/*a', to: 'application#not_found'
end