class RentalsController < ApplicationController
  def index
    # lists all customers with overdue movies
    # returns title, customer_id, name, post_code, checkout date, duedate
    # it will check the returned column to get the list
  end

  def create
    # must be given title, customer_id, duedate
    # returns confirmation
    # returned is false (default)
    # set the duedate
    # updates movies available inventory
  end

  def update
    # must be give customer_id, title
    # returns confirmation
    # changes returned to true
    # updates movie's available inventory
  end
end
