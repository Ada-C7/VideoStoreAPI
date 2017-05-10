Rails.application.routes.draw do
  get "movies", to: "movies#index", as: "movies"

  get "movie/:id", to: "movies#show", as: "movie"

  get "customers", to: "customers#index", as: "customers"

  get "customer/:id", to: "customers#show", as: "customer"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
