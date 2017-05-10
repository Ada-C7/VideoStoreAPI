Rails.application.routes.draw do
  get 'rental/overdue'

  get 'rental/check_out'

  get 'rental/check_in'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "customers", to: "customers#index"
  get "movies", to: "movies#index"
  get "movies/:title", to: "movies#show", as: 'movie'
end
