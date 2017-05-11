class RentalsController < ApplicationController
  def index
    # lists all customers with overdue movies
    # returns title, customer_id, name, post_code, checkout date, duedate
  end

  def create
    # must be given title, customer_id, duedate
    # returns confirmation
    # returned is false
    # set the duedate
    # updates movies available inventory
  end

  def update
    # must be give customer_id, title
    # returns confirmation
    # returned updates to true
    # updates movies available inventory
  end
end
