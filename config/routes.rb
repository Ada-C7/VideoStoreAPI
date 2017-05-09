Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# GET /customers, #index

# GET /movies, #index

# GET /movies/:title #show
# params: title

# POST /rentals/:title/check-out
# params: title
# request_body: customer_id, due_date

# POST /rentals/:title/check-in
# params: title
# request_body: customer_id

# GET /rentals/overdue

# get "/zomg", to: "movies#zomg"

end
