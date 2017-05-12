Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get "/zomg", to: "movies#zomg"
  get "/movies", to:"movies#index", as: "movies"
  get "/customers", to:"customers#index", as:"customers"
  get "movies/:title", to:"movies#show", as: "movie"

  post "/rentals/:title/check-out", to:"rentals#checkout", as: "checkout"

end
