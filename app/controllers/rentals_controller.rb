class RentalsController < ApplicationController

  def check_in
    # +1 to available inventory
    # change rental status to "previously rented"
  end

  def check_out
    # if available inventory > 0
    if movie(params[:title]).inventory > 0
      # -1 from available inventory
      inventory - 1
      # change rental status to "checked out "
      status = "checked out"
      # set check out day to today
      check_out_date = Time.now
      # set due date of 30 days after today
      due_date = Time.now + 30.days
      # else
    else
      # give error message that movie isn't available
      render status: :bad_request, json: { errors: movie.errors.messages }
    end

  end

  def overdue
    # if due date is 31 days ago
    # change status to "overdue"
  end

end
