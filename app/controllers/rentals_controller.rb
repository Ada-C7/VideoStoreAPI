# require 'date'

class RentalsController < ApplicationController

  def create
    # example of params
    # {"rental"=>{ "customer_id"=>1 }, "title"=>"Psycho"}
    movie = Movie.find_by(title: params[:title])
    if movie


      rental_info = { customer_id: params["rental"]["customer_id"],
                      movie_id: movie.id
                    }

      if Rental.where(status: "checked out",
                      movie_id: movie.id,
                      customer_id: params["rental"]["customer_id"]).length > 0
        render status: :bad_request, json: { error: "Customer has this movie currently checked out" }
      else
        rental = Rental.create_rental(rental_info)
        if rental.errors.empty?
          rental.save
          render status: :ok, json: { rental_id: rental.id }
        else
          render status: :bad_request, json: { errors: rental.errors.messages }
        end
      end

    else
      render status: :bad_request, json: { errors: "movie does not exist" }
    end
  end

  def update
    movie = Movie.find_by(title: params[:title])
    rental = Rental.find_by(movie_id: movie.id, customer_id: params["rental"]["customer_id"])

    rental.return_date = Date.today
    rental.status = "checked in"
    rental.customer.movies_checked_out_count -= 1

    if rental.save
      render status: :ok, json: { status: rental.status }
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end

  def overdue_rentals
    overdue_rentals = Rental.overdue_movies
    if overdue_rentals.empty?
      render json: { message:  "No overdue rentals was found" }, status: :ok
    else
      render json: overdue_rentals, each_serializer: OverdueListSerializer, status: :ok
    end
  end

  private
  def rental_params
    params.require(:rental).permit(:customer_id, :title, :check_out_date,
    :return_date, :due_date, :status)
  end
end
