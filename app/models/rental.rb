class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates :due_date, presence: true

  def self.overdue
    #get all of the rentals w/ a status that is NOT "returned"
    rentals = Rental.all
    overdues = []
    #iterate through and check if due_date is past

    rentals.each do |rental|
      due = Date.parse (rental.due_date)
      if due.past?
        overdues << rental
      end
    end
    #if rental.due_date.past?
    #returns an array of rental objects that are overdue.
    return overdues
  end
end
