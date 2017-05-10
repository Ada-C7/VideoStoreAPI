class RentalController < ApplicationController
  def overdue
  end

  def check_out
    # set checkout_date to today's date
    # set due_date to a week from today's date
    
  end

  def check_in
  end

  private

  def rental_params
    params.require(:rental).permit(:customer_id, :movie_id)
  end
end
