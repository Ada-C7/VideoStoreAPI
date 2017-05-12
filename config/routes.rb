Rails.application.routes.draw do

  get "movies", to: "movies#index", as: "movies"
  get "movies/:title", to: "movies#show", as: "movie"
  post "/movies", to:"movies#create"

  get "/customers", to: "customers#index", as: "customers"
  get "/customers/:id", to: "customers#show", as: "customer"

  post "/rentals/:title/check_out", to: "rental#create", as:"rental"
  patch "/rentals/:title/check_in", to: "rental#update", as:"check_in"

  get "/zomg", to: "tests#bla"

end
