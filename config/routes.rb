Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => redirect('api/v1')
  # API
  namespace :api do
    namespace :v1 do
      resources :products do
        get :version
      end
    end
  end

  get 'api/v1', to: 'api/v1/products#version', as: :api_version
end
