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

  def checkin
    movie =  Movie.find_by(title: params[:title].capitalize)
    customer_id = rental_params[:customer_id]
    rentals = Rental.where(movie_id: movie.id, customer_id: customer_id)
    rental = rentals[0]

    if rental.nil?
      render status: :bad_request, json: { errors: "There was a problem. Could not check in your movie." }
    else
      if rental.checked_out == false
        render status: :bad_request, json: { errors: "Your movie was already checked in." }
      else
      rental.checked_out = false
      rental.save
      render status: :ok, json: { id: rental.id }
      end
    end

  end


  private

  def rental_params
    params.require(:rental).permit(:customer_id, :due_date)
  end

end
