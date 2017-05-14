class RentalsController < ApplicationController

  def create
    rental = Rental.new
    rental.movie = Movie.find_by title: params[:title]
    rental.customer = Customer.find(params[:rental][:customer_id])
    rental.due_date = params[:rental][:due_date]
     if rental.save
       rental.movie.available_inventory = rental.movie.inventory - 1
       render status: :ok, json: { id: rental.id }
     else
       render statis: :bad_request, json: { errors: rental.error.messages }
     end
  end

end
