class RentalController < ApplicationController

  def overdue
  end

  def checkout
  end

  def checkin
  end

  private

  def rental_params
    # params.require(:rental).permit(:customer_id, :movie_id)
  end
end
