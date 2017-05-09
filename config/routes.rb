Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'movies', to: 'movies#index', as: 'movies'
  get 'movies/:title', to: 'movies#show', as: 'movie'

end
