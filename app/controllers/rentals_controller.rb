class RentalsController < ApplicationController

  def create
    rental = Rental.new(rental_params)
    rental.movie = Movie.find_by title: params[:title]
    rental.check_out = Date.today
     if rental.movie.available_inventory == 0
       render status: :bad_request, json: { error: "Not enough inventory" }
     elsif rental.save
       render status: :ok, json: { id: rental.id }
       rental.customer.movies_checked_out_count += 1
     else
       render statis: :bad_request, json: { errors: rental.errors.messages }
     end
  end

  private

  def rental_params
    params.require(:rental).permit(:customer_id, :due_date)
  end
end
