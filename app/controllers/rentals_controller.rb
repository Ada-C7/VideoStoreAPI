class RentalsController < ApplicationController
  def checkout
    movie = Movie.find_by(title: params[:title].capitalize)

    if movie && movie.available_inventory <= 0
      render status: :bad_request, json: { errors: { inventory: ["#{movie.title} is not in stock"] } }
    else
      rental = Rental.new(customer_id: params["customer_id"], movie: movie, due_date: params["due_date"])
      if rental.save
        render json: { id: rental.id }, status: :ok
      else
        render status: :bad_request, json: { errors: rental.errors.messages }
      end
    end
  end

  def checkin
    movie = Movie.find_by(title: params[:title].capitalize)
    rental = Rental.find_by(returned: false, movie: movie, customer_id: params["customer_id"])
    if movie && rental
      rental.update_attributes(returned: true)
      render json: { id: rental.id, returned: rental.returned }, status: :ok
    else
      render status: :bad_request, json: { errors: { rental: ["There is no current rental of '#{params[:title]}'"] } }
    end
  end
end
