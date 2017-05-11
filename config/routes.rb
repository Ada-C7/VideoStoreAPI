Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/zomg', to: 'application#index', as: 'zomg'
  resources :customers, only: [:index]
  resources :movies, only: [:index]
  get '/movies/:title', to: 'movies#show', as: 'movie'

  post '/rentals/:title/checkout', to: 'rentals#checkout', as: 'checkout'
  post '/rentals/:title/checkin', to: 'rentals#checkin', as: 'checkin'
  get '/rentals/overdue', to: 'rentals#overdue', as: 'overdue'
  
end
