Rails.application.routes.draw do
  # get "/zomg", to: 'customers#index'

  # CUSTOMERS:
  # /customers #all  for returning all customers
  get "/customers", to: "customers#index", as: "customers" 

  # MOVIES:
  # /movies #all  for returning all ovies
  # /movie #find(title)  for a movie by title

  # RENTALS:
  # (optional)

end
