Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      # movies routes
      resources :movies
      # shows routes
      resources :shows
      # people routes
      resources :people
    end
  end

  mount_devise_token_auth_for 'User', at: '/api/v1/auth'
end
