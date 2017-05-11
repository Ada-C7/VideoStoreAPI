class Rental < ApplicationRecord
  validates_format_of :due_date, with: /\d{4}\-\d{2}\-\d{2}/, message: "Due date must be formatted as 'yyyy-mm-dd'."
  belongs_to :movie
  belongs_to :customer

  def checkout_date
    created_at.strftime("%F")
  end

  def self.overdue
    all.map { |rental|
      rental.customer if Date.parse(rental.due_date).past? && rental.is_current
    }.compact
  end

end
