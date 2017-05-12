Rails.application.routes.draw do
  get "zomg", to: "movies#zomg"
  get "customers", to: "customers#index", as: "customers"
  get "movies", to: "movies#index", as: "movies"
  get "movies/:title", to: "movies#show", as: "movie"
  post "rentals/:title/check-out", to: "rentals#checkout", as: "checkout"
  post "rentals/:title/check-in", to: "rentals#checkin", as: "checkin"
  get "rentals/overdue", to: "rentals#overdue", as: "overdue"
end
