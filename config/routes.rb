Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/zomg", to: "movies#zomg", as: "zomg"
  get '/customers', to: 'customers#index', as: 'customers' ## no further params needed
  get '/movies', to: 'movies#index', as: 'movies' ## no further params needed
  # get '/movies/:title', to: 'movies#show', as: 'movie' ## must provide movie title

end
