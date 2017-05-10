Rails.application.routes.draw do
  get 'rentals/create'

  get 'rentals/update'

  get 'rentals/overdue'

  get '/movies', to: 'movies#index', as: 'movies'

  get '/movies/:title', to: 'movies#show', as: 'movie'

  get '/customers', to: 'customers#index', as: 'customers'

  post '/rentals/:title/check-out', to: 'rentals#create', as: 'check_out'

  post 'rentals/:title/check-in', to: 'rentals#update', as: 'check_in'

  get 'rentals/overdue', to: 'rentals#overdue', as: 'overdue'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/zomg', to: 'application#index'
end
