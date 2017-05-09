Rails.application.routes.draw do

  get "/movies", to: "movies#index", as: "movies"
  get "/movies/:id", to: "movies#show", as: "movie"

  get "/customers", to: "customers#index", as: "customers"
  get "/customers/:id", to: "customers#show", as: "customer"

end
