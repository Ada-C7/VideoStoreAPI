Rails.application.routes.draw do

     get '/customers', to: 'customers#index', as: 'customers'

end
