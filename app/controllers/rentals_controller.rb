class RentalsController < ApplicationController

  def checkout
    movie = Movie.find_by(title: params[:title])
    if movie
      customer = Customer.find_by_id(params[:customer_id])
      due_date = params[:due_date]

      rental = Rental.new(due_date: due_date, customer_id: customer.id, movie_id: movie.id, returned: false)

      if rental.save
        render status: :ok, json: rental.as_json(except: [:updated_at, :created_at])
      else
        render status: :bad_request, json: { errors: rental.errors.messages }
      end
    else
      render json: {errors: {title: ["Movie '#{params[:title]}' not found"]} }, status: :not_found
    end

    
  end


end
