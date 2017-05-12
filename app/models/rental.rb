class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  #potentially need to comment the below out for a while...
  # due date has to be after today
  validates :due_date, presence: true

  after_initialize :set_defaults, unless: :persisted?

  private
  def set_defaults
    self.returned = false if self.returned.nil?
  end
end
