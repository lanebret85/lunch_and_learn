Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/api/v1/recipes", to: "api/v1/recipes#index"
  get "/api/v1/learning_resources", to: "api/v1/resources#index"

  post "/api/v1/users", to: "api/v1/users#create"
  post "/api/v1/sessions", to: "api/v1/sessions#create"
  post "/api/v1/favorites", to: "api/v1/favorites#create"
end
