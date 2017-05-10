class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :due_date, presence: true
  validate :valid_due_date



  def valid_due_date
    if due_date.class == Date && due_date > Date.current
      return true
    else
      return false
    end
  end


end
