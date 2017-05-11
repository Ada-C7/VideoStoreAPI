Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "customers", to: "customers#index", as: "customers"
  get "customers/:id", to: "customers#show" 

  get 'movies', to: 'movies#index', as: 'movies'
  get 'movies/:title', to: 'movies#show', as: 'movie'


  post "/rentals/:title/check-out", to: "rentals#create", as: "create_rental"
  patch "/rentals/:title/check-in", to: "rentals#update", as: "update_rental"

  get "/rentals/overdue", to: "rentals#overdue_rentals", as: "overdue_rentals"
end
