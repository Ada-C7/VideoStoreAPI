class RentalsController < ApplicationController

  def create
    rental = Rental.new
    rental.movie = Movie.find_by title: params[:title]
    rental.customer = Customer.find(params[:rental][:customer_id])
    rental.due_date = params[:rental][:due_date]
    rental.check_out = Date.today
     if rental.movie.available_inventory < 0
       render status: :bad_request, json: { error: "Not enough inventory" }
     elsif rental.save
       render status: :ok, json: { id: rental.id }
       rental.customer.movies_checked_out_count += 1
     else
       render statis: :bad_request, json: { errors: rental.error.messages }
     end
  end

end
