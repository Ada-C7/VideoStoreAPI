Rails.application.routes.draw do

get "/zomg"

get "/movies", to: "movies#index", as: "movies"

get "/customers", to: "customers#index", as: "customers"

get "/movies/:title", to: "movies#show"

get "/customers/:id", to: "customers#show"

end
