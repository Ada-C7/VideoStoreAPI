Rails.application.routes.draw do

get "/movies", to: "movies#index", as: "movies"

get "/customers", to: "customers#index", as: "customers"

get "/movies/:title", to: "movies#show", as: "movie"

get "/customers/:id", to: "customers#show", as: "customer"

post "/rentals/:title/checkout", to: "rentals#checkout", as: "checkout"


end
