Rails.application.routes.draw do
  # get "/zomg", to: 'customers#index'

  # CUSTOMERS:
  # /customers #all  for returning all customers
  get "/customers", to: "customers#index", as: "customers"

  # MOVIES:
  # /movies #all  for returning all ovies
  get "/movies", to: "movies#index", as: "movies"
  get "/movies/:title", to: "movies#show", as: "movie"
  # /movie #find(title)  for a movie by title

  # RENTALS:
  # (optional)
  post "/rentals/:title/check-out", to: "movies#checkout", as: "checkout"
end
