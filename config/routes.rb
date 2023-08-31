Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/", to: "static_pages#index"
  end
end
