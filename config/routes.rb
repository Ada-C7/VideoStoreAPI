Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#create a route that responds to /zomg that serves a json-encoded "it works!"

#routes for customers
get "customers", to: "customers#index", as: "customers"
get "customers/:id", to: "customers#show", as: "customer"

# post "customers", to: "customers#create", as: "customers"




#route for get /customers returns list of all customers with fields of info

#routes for movies

#route for get/movies - returns list of movies with fields

#route for getting a single movie - parameter is a movie title, returns single moveiwith fields of info

#routes for rentals?

end
