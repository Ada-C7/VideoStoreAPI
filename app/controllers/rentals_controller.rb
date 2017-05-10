class RentalsController < ApplicationController
  def create
    rental = Rental.new(rental_params)

    if rental.save
      render status: :ok, json: {rental_success: true}
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
    params.require(:rental).permit(:due_date, :customer_id, :title)
  end

end
