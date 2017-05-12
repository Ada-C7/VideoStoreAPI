class RentalsController < ApplicationController
  def checkout
    movie = Movie.find_by(title: params[:title])
    rental_info = {
      customer_id: rental_params[:id],
      movie_id: movie.id,
      checkout_date: Date.today,
      due_date: Date.today + 7
    }
    rental = Rental.new(rental_info)

    if rental.save!
      render status: :ok, json: {message: "Thanks for checking out #{movie.title}. Your due date is #{rental.due_date}."}
    else
      render status: :bad_request, json: {errors: rental.errors.messages}
    end
  end

  def checkin
    rental = Rental.find_by(id: params[:rentals][:id])

    checkin_info = {
      checkin_date: Date.today
    }
    rental = Rental.update(checkin_info)

    if rental
      render status: :ok, json: {message: "Thanks for checking in!"}
    else
      render status: :bad_request, json: {errors: rental.errors.messages}
    end
  end

  def overdue
    overdue_rentals = Rental.overdue

    if overdue_rentals
      render :json => overdue_rentals, status: :ok
    else
      render status: :not_found, json: {errors: "overdue not found in db."}
    end
  end

  private

  def rental_params
    params.require(:customers).permit(:id)
  end

end
