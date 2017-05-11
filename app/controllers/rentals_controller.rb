# require 'date'

class RentalsController < ApplicationController

  def create
    # example of params
    # {"rental"=>{ "customer_id"=>1 }, "title"=>"Psycho"}

    movie = Movie.find_by(title: params[:title])
    if movie
      rental_info = {
                      customer_id: params["rental"]["customer_id"],
                      movie_id: movie.id
                    }
      rental = Rental.create_rental(rental_info)
      if rental.save
        render status: :ok, json: { id: rental.id }
      else
        render status: :bad_request, json: { errors: rental.errors.messages }
      end
    else
      render status: :bad_request, json: { errors: "movie does not exist" }
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
