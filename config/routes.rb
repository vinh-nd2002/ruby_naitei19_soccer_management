Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    # root "static_pages#index"
    # User scope
    scope module: "user" do
      root "static_pages#index"

      # resources
      resources :football_pitches, only: %i(index)
      resources :favorite_pitches, only: %i(index create destroy)
      resources :static_pages
      resources :account_activations, only: %i(edit)
      resources :users do
        member do
          patch "update_password"
        end
      end
      resources :bookings
    end

    # Admin scope
    namespace :admin do
      get "/", to: "static_pages#index"

      # resources
      resources :users
      resources :football_pitches
      resources :bookings, only: %i(index update)
    end

    get "/signup",  to: "registers#new"
    post "/signup",  to: "registers#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :account_activations, only: [:edit]
    resources :password_resets, only: %i(new create edit update)
  end
end
