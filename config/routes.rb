Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/customers', to: 'customers#index', as: 'customers'
  get '/movies', to: 'movies#index', as: 'movies'
  get '/movies/:title', to: 'movies#show', as: 'movie'



  get '/rentals/overdue', to: 'customers#overdue', as: 'overdue'

  post '/movies/:title/check-out', to: 'movies#checkout', as: 'checkout'
  post '/movies/:title/check-in', to: 'movies#checkin', as: 'checkin'

end
