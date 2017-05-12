class RentalsController < ApplicationController

  def checkout

    movie = Movie.find_by(title: params[:title])
    rental = Rental.new(rental_params)
    rental.movie_id = movie.id
    #need to find customer by rental id.

    customer = Customer.find_by_id(rental.customer_id)

    if customer.nil?
      render status: :bad_request, json: { errors: {
        customer: ["The Customer ID does not exist"] } }
    elsif movie.available_inv > 0
      # -1 from available inventory
      movie.available_inv -= 1
      # change rental status to "checked out "
      rental.status = "checked out"
      # set due date of 30 days after today
      rental.due_date = Time.now + 30.days

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
      #adding into status so don't find rental that's already been checked in!
      rental = Rental.find_by(customer_id: rental_params[:customer_id], movie_id: movie.id, status: "checked out")
      if !rental
        render status: :not_found, json: {errors: {rental: ["Rental not found" ]}}
      end
    end

    if movie && rental
      movie.available_inv += 1
      movie.save

      rental.status = "Returned"
      rental.save

      render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok

      # render status: :ok, json: { message: "Your movie has been returned."}
    end

  end

  def overdue
    # if due date is 31 days ago
    overdues = Rental.overdue

    if overdues == []
      render status: :not_found, json: {errors: {rentals: ["No Overdue Rentals" ]}}
    else
      render json: overdues.as_json(only:[:customer_id, :due_date], methods: :info_for_overdues), status: :ok
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:customer_id)
  end

end
