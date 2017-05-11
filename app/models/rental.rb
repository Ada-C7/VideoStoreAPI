class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :due_date, presence: true


  def self.overdue
    self.all.select {|rental| (rental.checked_out == true) &&  (rental.due_date.past?)}
  end

end
