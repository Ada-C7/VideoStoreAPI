Rails.application.routes.draw do
  
  get 'customers', to: 'customers#index', as: 'customers'

  get 'movies', to: 'movies#index', as: 'movies'
  get 'movies/:title', to: 'movies#show', as: 'movie'

end
