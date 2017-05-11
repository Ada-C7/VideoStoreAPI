class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer, counter_cache: true

  validates :duedate, presence: true

  def overdue?
    Date.parse(self.duedate.to_s) < Date.today
  end
end
