class RentalsController < ApplicationController

   def checkout
     movie = Movie.find_by(title: params[:title])
     customer = Customer.find_by_id(params[:customer_id])
     due_date = params[:due_date]

     rental = Rental.new(due_date: due_date, customer: customer.id, movie: movie.id, is_current: true)
    #  checkout_date = rental.created_at
     render json: rental.as_json(only: :created_at)



   end


end
