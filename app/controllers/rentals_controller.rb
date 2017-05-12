class RentalsController < ApplicationController

  # example of params: {"rental"=>{ "customer_id"=>1 }, "title"=>"Psycho"}
  def create
    movie = Movie.find_by(title: params[:title])
    customer = Customer.find_by(id: params["rental"]["customer_id"])

    if !movie.nil? && !customer.nil?
      rental_info = { customer_id: customer.id,
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
      render status: :bad_request, json: { errors: "movie and/or customer does not exist" }
    end
  end

  def update
    movie = Movie.find_by(title: params[:title])
    if movie
      if Rental.where(status: "checked out", movie_id: movie.id,
        customer_id: params["rental"]["customer_id"]).length == 0
        render status: :bad_request, json: { error: "You cannot check in movie, that you did not checked out "}
      else
        rental = Rental.find_by(movie_id: movie.id, customer_id: params["rental"]["customer_id"])
        if rental.status == "checked in"
          render status: :ok, json: { error: "Movie is already checked in" }
        else
          rental.return_date = Date.today
          rental.status = "checked in"
          rental.customer.movies_checked_out_count -= 1
          rental.customer.save
          rental.movie.available_inventory += 1
          rental.movie.save
          if rental.save
            render status: :ok, json: { status: rental.status }
          else
            render status: :bad_request, json: { errors: rental.errors.messages }
          end
        end
      end
    else
      render status: :bad_request, json: { errors: "movie does not exist" }
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
end
