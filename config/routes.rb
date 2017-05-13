Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/movies', to: 'movies#index', as: 'movies'
  get '/movies/:title', to: 'movies#show', as: 'movie'
  post '/movies', to: 'movies#create'

  get '/customers', to: 'customers#index', as: 'customers'
  post '/customers', to: 'customers#create'

  post '/rentals/:title/check-out', to: 'rentals#checkout_movie', as: 'checkout'
  post '/rentals/:title/check-in', to: 'rentals#checkin_movie', as: 'checkin'

  get '/rentals/overdue', to: 'rentals#find_overdue', as: 'overdue'
  # get '/zomg', to: 'application#index', as: 'zomg'
end
