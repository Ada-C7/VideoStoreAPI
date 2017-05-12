
class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer, counter_cache: true

  validates :duedate, presence: true
  validate :duedate_not_in_the_past


def duedate_not_in_the_past
  # binding.pry
  if self.duedate <= Date.today
    errors.add(:duedate, "can't be in the past")
  end
end


  def overdue?
    Date.parse(self.duedate.to_s) < Date.today
  end

  def self.list_of_overdue
    rentals = Rental.all
    overdue_rentals = []
    rentals.each do |rental|
      if rental.overdue?
        overdue_rentals << rental
      end
    end
    return overdue_rentals
  end


end
