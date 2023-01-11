Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'teas/index'
    end
  end
  namespace :api do
    namespace :v1 do
      get 'customers/index'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :teas, only: :index
      resources :customers, only: :index do
        resources :subscriptions, only: %i[create update index]
      end
    end
  end
end
