Rails.application.routes.draw do
  get 'movies/index'

  get 'movies/show'

  get 'customers/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/zomg', to: 'application#index'
end
