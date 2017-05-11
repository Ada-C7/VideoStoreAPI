class RentalController < ApplicationController

  def overdue

  end

  def checkout
    movie_id = Movie.find(title: (params: title))
    rental = Rental.new(rental_params)

    if rental.save
      render json: variable.as_json(only: ["customer_id", "due_date", "movie_id"]),
      status: :ok
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end

  def checkin
  end

  private

  def rental_params
    params.require(:rental).permit(:customer_id, :due_date)
  end
end
