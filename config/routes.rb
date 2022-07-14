Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :api do 
    namespace :v1 do 

      get '/merchants/find', to: 'merchant_search#show'
      get '/items/find_all', to: 'item_search#index'

      resources :merchants, only: %i[index show] do 
        resources :items, only: %i[index], controller: 'merchant_items'
      end 
      
      resources :items do 
        resources :merchant, only: [:index], controller: 'item_merchants'
      end
    end
  end
end
