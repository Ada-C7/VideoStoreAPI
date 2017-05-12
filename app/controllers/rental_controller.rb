class RentalController < ApplicationController

  def overdue

  end

  def checkout
    rental = Rental.new(rental_params)
    rental.movie_id = Movie.find_by(title: params[:title]).id

    if rental.save
      render json: rental.as_json(only: ["customer_id", "due_date", "movie_id"]
      ),
      status: :ok
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end

  def checkin
    # find rental and change 'returned' to true
  end

  private

  def rental_params
    params.require(:rental).permit(:customer_id, :due_date)
  end
end
