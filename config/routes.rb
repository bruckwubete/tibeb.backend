Rails.application.routes.draw do


  namespace :api, defaults: {format: :json} do
    namespace :v1 do
        
        #movies routes
        get '/movies/details/:id', to: 'movies#show'
        get '/movies/watch/:id', to: 'movies#watch'
        get '/movies/popular', to: 'movies#popular'
        get '/movies/search/:title', to: 'movies#search'
        get '/movies/discover', to: 'movies#discover'
        get '/movies/genres', to: 'movies#genres'
        
        #shows routes
        get '/shows/details/:id', to: 'shows#show'
        get '/shows/popular', to: 'shows#popular'
        get '/shows/search/:title', to: 'shows#search'
        get '/shows/discover', to: 'shows#discover'
        get '/shows/genres', to: 'shows#genres'
        
        
        #people routes
        get '/people/details/:id', to: 'people#show'
        get '/people/popular', to: 'people#popular'
        get '/people/search/:title', to: 'people#search'
        
        
    end
  end

   mount_devise_token_auth_for 'User', at: '/api/v1/auth'
  

  #application root
  root 'home#index'





  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
