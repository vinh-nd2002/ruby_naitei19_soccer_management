Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    get "/", to: "static_pages#index"
    get  "/signup",  to: "users#new"
    resources :users
  end
end
