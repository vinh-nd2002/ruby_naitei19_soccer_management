Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    # User scope
    scope module: "user" do
      root "static_pages#index"

      # resources
      resources :football_pitches, only: %i(index)
      resources :static_pages
    end

    # Admin scope
    namespace :admin do
      get "/", to: "static_pages#index"
      resources :users
      resources :football_pitches
    end

    get "/signup",  to: "registers#new"
    post "/signup",  to: "registers#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
end
