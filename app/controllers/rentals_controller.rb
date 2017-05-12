class RentalsController < ApplicationController
  def create
    rental_info = rental_params
    rental_info[:title] = params[:title]
    rental = Rental.new(rental_info)
    if rental.save
      render status: :ok, json: {id: rental.id}
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end

  def update
    movie = Movie.find_by(title: params[:title] )
    rental = Rental.find_by(movie_id: movie.id, customer_id: rental_params[:customer_id], returned: false)
    if rental
      rental.returned = true
      if rental.save
        render status: :ok, json: { movie_returned: true }
      end
    elsif Rental.find_by(movie_id: movie.id, customer_id: rental_params[:customer_id], returned: true)
      render status: :bad_request, json: { errors: { check_in: "Customer has already checked in this movie"}}
    else
      render status: :bad_request, json: { errors: { check_in: "Cannot find this rental"} }
    end
  end

  def overdue
    rentals = Rental.all
    render json: rentals.as_json
  end

  private

  def rental_params
    params.require(:rental).permit(:due_date, :customer_id)
  end

end
