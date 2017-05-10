class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.movie =  Movie.find_by(title: params[:title].capitalize)
    rental.checked_out = true
    if rental.save
      render status: :ok, json: { id: rental.id }
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:customer_id, :due_date)
  end
end
