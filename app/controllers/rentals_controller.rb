class RentalsController < ApplicationController
  def check_out
    movie = Movie.find_by(title: params[:title])
    customer = Customer.find_by_id(params[:customer_id])
    due_date = params[:due_date]

    rental = Rental.new(due_date: due_date, customer: customer, movie: movie)

    if rental.save
      render status: :ok, json: rental.as_json(except: [:updated_at, :created_at])
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end
end
