Rails.application.routes.draw do

  get 'customers', to: 'customers#index', as: 'customers'

  get 'movies', to: 'movies#index', as: 'movies'
  get 'movies/:title', to: 'movies#show', as: 'movie'

  post 'rentals/:title/check-out', to: 'movies#checkout', as: 'checkout'
  post 'rentals/:title/check-in', to: 'movies#checkin', as: 'checkin'
  get 'rentals/overdue', to: 'rentals#overdue', as: 'overdue'
end
