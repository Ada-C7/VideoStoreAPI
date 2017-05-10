Rails.application.routes.draw do

  get '/movies', to: 'movies#index', as: 'movies'

  get '/customers', to: 'customers#index', as: 'customers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
