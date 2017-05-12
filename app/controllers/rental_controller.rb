class RentalController < ApplicationController

  def overdue

  end

  def checkout
    rental = Rental.new(rental_params)
    rental.movie_id = Movie.find_by(title: params[:title]).id

    if movie_available(rental.movie.id)
      if rental.save
        render json: rental.as_json(only: ["customer_id", "due_date", "movie_id"]
        ),
        status: :ok
      else
        render status: :bad_request, json: { errors: rental.errors.messages }
      end
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

  def movie_available(movie_id)
    movie = Movie.find(movie_id)
    if movie.available_inventory >= 1
      return true
    else
      return false
    end
  end
end
