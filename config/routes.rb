Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get "zomg", to: "movies#zomg", as: "zomg"

  get "movies", to: "movies#index", as: "movies"

  get "movies/:title", to: "movies#show", as: "movie"

  post "/movies", to: 'movies#create'

  get '/customers', to: 'customers#index', as: 'customers' #do

    # post '/rentals/:title/check-out', to: 'rentals#create', as: 'check-out'


end
