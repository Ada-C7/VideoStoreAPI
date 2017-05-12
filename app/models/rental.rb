require 'date'

class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def check_out
    must associate title with rental
    must associate rental with customer
    must decrement title inventory
    must reference date
    Date.parse("2014-1-1")
    Date.today
    Date.strptime("%m/%d/%Y")
  end

  def check_in
    must reference the date
    must increment title inventory
  end

  def overdue?
    must reference
    must reference the date plus default counter of days from checked_out-date
    must reference either check_in or checked_out? method equalling true or false
    should return something like customer.rental.title.overdue? == true or false
  end
end
