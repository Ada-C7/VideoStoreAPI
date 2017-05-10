require 'date'

class RentalsController < ApplicationController

  def index
    rentals = Rental.all
  end
  def create
    rental = Rental.new
    movie = Movie.find_by(title: params[:title])
    rental.movie_id = movie.id
    rental.check_out_date = Date.today
    # rental.return_date = nil
    rental.due_date = check_out_date + 3
    rental.status = "checked out"

    rental.customer_id = params[:customer_id]
    customer = Customer.find(params[:customer_id])

    customer.movies_checked_out_count += 1
    # movie.available_inventory = inventory - 1 # ??????????
    if rental.save
      render status: :ok, json: { id: rental.id }
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end

  def update
    rental = Rental.find_by(title: params[:title], customer_id: params[:customer_id])
    rental.return_date = Date.today

    rental.customer.movies_checked_out_count += 1
    rental.movie.available_inventory += 1 # ??????????
    rental.status = "checked in"

    if rental.save
      render status: :ok, json: { id: rental.status }
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end






  private
  def rental_params
    params.require(:rental).permit(:customer_id, :title, :check_out_date,
    :return_date, :due_date, :status)
  end
end
