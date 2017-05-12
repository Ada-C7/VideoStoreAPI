class RentalsController < ApplicationController
  def create
    rental_info = rental_params
    rental_info[:title] = params[:title]
    rental = Rental.new(rental_info)
    if rental.save
      render status: :ok, json: {id: rental.id}
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end

  def update
  end

  def overdue
  end

  private

  def rental_params
    params.require(:rental).permit(:due_date, :customer_id)
  end

end
