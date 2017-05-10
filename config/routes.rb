Rails.application.routes.draw do
  get "movies", to: "movies#index", as: "movies"

  get "movie/:id", to: "movies#show", as: "movie"

  get 'movies/show'

  get 'customers/index'

  get 'customers/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
