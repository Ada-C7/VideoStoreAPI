class RentalController < ApplicationController

  def overdue
    # title
    # customer_id
    # name
    # postal_code
    # checkout_date
    # due_date
  end

  def checkout
    rental = Rental.new(checkout_params)
    rental.movie_id = get_movie_id(params[:title])
    if movie_available?(rental.movie.id)
      if rental.save
        render json: rental.as_json(only: ["customer_id", "due_date", "movie_id"]
        ),
        status: :ok
      else
        render status: :bad_request, json: { errors: rental.errors.messages }
      end
    else
      print rental.errors.messages
      render status: :bad_request, json: { errors: "Movie unavailable" }
    end
  end

  def checkin
    movie_id = get_movie_id(params[:title])
    customer_id = checkin_params[:customer_id]
    rental = Rental.find_by(customer_id: customer_id, movie_id: movie_id)
    rental.returned = true
    if rental.save
      render json: rental.as_json(only: ["customer_id", "movie_id", "returned"]),
      status: :ok
    else
      render status: :bad_request, json: { errors: rental.errors.messages}
    end
  end

  private

  def checkout_params
    params.require(:rental).permit(:customer_id, :due_date)
  end

  def checkin_params
    params.require(:checkin).permit(:customer_id)
  end

  def get_movie_id(title)
    return Movie.find_by(title: title).id
  end

  def movie_available?(movie_id)
    movie = Movie.find(movie_id)
    movie.available_inventory >= 1 ? true : false
  end
end
