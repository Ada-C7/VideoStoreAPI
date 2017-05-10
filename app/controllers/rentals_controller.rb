class RentalsController < ApplicationController

  def create
    if Movie.find_by_title(params[:title]).nil?
      id = Movie.find_by_title(params[:title]).id
    else
      id = 0
    end

    rental = Rental.new(movie_id: id, customer_id: rental_params[:customer_id], due_date: rental_params[:due_date] )

    if rental.save
      render status: :ok, json: rental.as_json
    else
      render status: :error, json: { error: true }
    end


  end

  private

  def rental_params
    params.permit(:customer_id, :due_date)
  end

end
