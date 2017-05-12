class RentalsController < ApplicationController

  def checkout
    movie = find_movie #private method
    rental = Rental.new(rental_params)
    rental.movie_id = movie.id
    customer = Customer.find_by_id(rental.customer_id)

    if customer.nil?
      render status: :bad_request, json: { errors: {
        customer: ["The Customer ID does not exist"] } }
    elsif movie.available_inv > 0
      movie.available_inv -= 1
      customer.movies_checked_out_count += 1
      rental.status = "checked out"
      rental.due_date = Date.today + 30.days
      rental.save
      movie.save
      customer.save
      render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render status: :not_acceptable, json: {errors: {
        movie: ["The Movie #{params[:title]} is not available"] }}
    end
  end

  def checkin
    movie = find_movie #private method
    if !movie
      render status: :not_found, json: {errors: {movie: ["#{params[:title]} not found" ]}}
    else
      rental = Rental.find_by(customer_id: rental_params[:customer_id], movie_id: movie.id, status: "checked out")
      if !rental
        render status: :not_found, json: {errors: {rental: ["Rental not found" ]}}
      elsif movie.available_inv < movie.inventory
        movie.available_inv += 1
        movie.save
        rental.status = "Returned"
        rental.save
        render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok
      else
        render status: :not_found, json: {errors: {rental: ["This rental will over increase our inventory" ]}}
      end
    end
  end

  def overdue
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

  def find_movie
    Movie.find_by(title: params[:title])
  end
end
