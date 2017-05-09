Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/zomg', to: 'application#index', as: 'zomg'
  resources :customers, only: [:index]
  resources :movies, only: [:index, :show]


  # post /rentals/:title/checkout
  # post /rentals/:title/checkin
  # get /rentals/overdue
end
