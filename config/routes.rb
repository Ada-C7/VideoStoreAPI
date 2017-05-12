Rails.application.routes.draw do
  get "customers", to: "customers#index", as: "customers"
  get "movies", to: "movies#index", as: "movies"
  get "movies/:title", to: "movies#show", as: "movie"

  # get "customer/:id", to: "customers#show", as: "customer"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
