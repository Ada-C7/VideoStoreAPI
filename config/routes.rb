Rails.application.routes.draw do
  get "movies", to: "movies#index", as: "movies"

  get 'movies/show'

  get 'customers/index'

  get 'customers/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
