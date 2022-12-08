Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/search#show'
      resources :merchants, only: [:index, :show] do
        get '/items', to: 'merchant_items#index'
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get 'merchant', to: 'item_merchant#show'
      end
    end
  end
end
