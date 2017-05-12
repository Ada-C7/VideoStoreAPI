class RentalsController < ApplicationController

  def checkout

    movie = Movie.find_by(title: params[:title])
    rental = Rental.new(rental_params)
    rental.movie_id = movie.id

    if rental.customer_id == nil
      render status: :bad_request, json: { errors: rental.errors.messages }
    end

    # if available inventory > 0
    if movie.available_inv > 0
      # -1 from available inventory
      movie.available_inv -= 1
      # change rental status to "checked out "
      rental.status = "checked out"
      # set due date of 30 days after today
      rental.due_date = Time.now.in_time_zone("Pacific Time (US & Canada)") + 30.days

      rental.save
      movie.save

      render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok
      # else
    else
      # give error message that movie isn't available
      render status: :not_acceptable, json: {errors: {
        movie: ["The Movie #{movie.title} is not available"] }}
    end
  end

  def checkin
    movie = Movie.find_by(title: params[:title])

    if !movie
      render status: :not_found, json: {errors: {movie: ["#{params[:title]} not found" ]}}
    else
      rental = Rental.find_by(customer_id: rental_params[:customer_id], movie_id: movie.id)
      if !rental
        render status: :not_found, json: {errors: {rental: ["Rental not found" ]}}
      end
    end

    if movie && rental
      movie.available_inv += 1
      movie.save

      rental.status = "Returned"
      rental.save

      render status: :ok, json: { message: "Your movie has been returned."}
    end

  end

  def overdue
    # if due date is 31 days ago
    overdues = Rental.overdue

    if overdues == []
      render status: :not_found, json: {errors: {rentals: ["No Overdue Rentals" ]}}
    else
      render json: overdues.as_json(only:[:customer_id, :created_at, :due_date], methods: :info_for_overdues), status: :ok
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:customer_id)
  end

end
