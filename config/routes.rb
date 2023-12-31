Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      get '/items/find', to: 'items#search'
      get '/merchants/find_all', to: 'merchants#search'
      resources :items do
        resources :merchant, only: [:index], controller: 'item_merchant'
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchant_items'
      end
    end
  end
end
