class RentalsController < ApplicationController

  def check_in
    # +1 to available inventory
    # change rental status to "previously rented"
  end

  def check_out
    # if available inventory > 0
    # -1 from available inventory
    # change rental status to "checked out "
    # set due date of 30 days after today
    # else
    # give error message that movie isn't available
  end

  def overdue
    # if due date is 31 days ago
    # change status to "overdue"
  end

end
