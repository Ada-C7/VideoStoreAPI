Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'customers', to: 'customers#index', as: 'customers'

  get 'movies', to: 'movies#index', as: 'movies'
  get 'movies/:title', to: 'movies#show', as: 'movie'

  post '/rentals/:title/checkout', to: 'customer_movies#checkout', as: 'checkout'
end
