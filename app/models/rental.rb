class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  after_initialize :set_defaults

  validates :due_date, presence: true
  validate :due_date_not_in_past
  validates :customer_id, presence: true


  def due_date_not_in_past
    if due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

  def set_defaults
    self.checkout_date ||= Date.today
    self.due_date ||= Chronic.parse('two weeks from today')
  end


end
