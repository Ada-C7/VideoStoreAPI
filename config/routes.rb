Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/customers", to: "customers#index"

  get "/movies", to: "movies#index"
  #
  get "/movies/:title", to: "movies#show", as: "movie"
  #
  post "/rentals/:title/check-out", to: "rentals#create", as: "checkout"
  # [post customer_id and due_date]
  #
  post "/rentals/:title/check-in", to: "rentals#update", as: "checkin"
  # [post customer_id]
  #
  # get "/rentals/overdue", to: "rentals#overdue"
end
