Rails.application.routes.draw do
  get 'movies', to: 'movies#index', as: 'movies'
  get 'movies/:title', to: 'movies#show', as: 'movie'
  get 'customers', to: 'customers#index', as: 'customers'

end
