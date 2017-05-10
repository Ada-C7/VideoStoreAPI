Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get "zomg", to: "movies#zomg", as: "zomg"
get "movies/:title", to:'movies#show', as:"movie"

  end
