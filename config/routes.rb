Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # movies routes
      resources :movies
      # shows routes
      resources :shows
      # actor routes
      resources :actors
      # crew routes 
      resources :crews
      # crew routes 
      resources :directors
    end
  end

  mount_devise_token_auth_for 'User', at: '/api/v1/auth', controllers: {
    registrations:  'overrides/registrations',
    sessions:  'overrides/sessions',
    token_validations:  'overrides/token_validations'
  }

  get '/apidocs' => redirect('/swagger-ui/')
end
