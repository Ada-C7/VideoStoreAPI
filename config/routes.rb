Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/customers', to: 'customers#index', as: 'customers' ## no further params needed
  get '/movies', to: 'movies#index', as: 'movies' ## no further params needed
  get '/movies/:title', to: 'movies#show', as: 'movie' ## must provide movie title

  post '/rentals/:title/check-out', to: 'rentals#create', as: 'checkout'
  post '/rentals/:title/check-in', to: 'rentals#update', as: 'checkin'
  get '/rentals/overdue', to: 'rentals#index', as: 'overdue'

end
