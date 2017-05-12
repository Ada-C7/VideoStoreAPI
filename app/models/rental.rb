class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :due_date, presence: true
  validates :movie_id, presence: true, numericality: true
  validates :customer_id, presence: true, numericality: true

  def overdue
    # check if due_date is before current due_date and rental's returned status is false
    if Date.parse(self.due_date).past? && self.returned == false
      return true
    else
      return false
    end
  end
end
