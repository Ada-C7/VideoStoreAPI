Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "customers", to: "customers#index"
  get "movies", to: "movies#index"
  get "movies/:title", to: "movies#show", as: 'movie'
  post "rentals/:title/checkout", to: "rental#checkout", as: 'checkout'
  post "rentals/:title/checkin", to: "rental#checkin", as: 'checkin'
  get "rentals/overdue", to: "rental#overdue", as: 'overdue'
end
