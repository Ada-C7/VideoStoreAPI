class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  def checkout_date
    created_at.strftime("%F")
  end

  def due_date
    start = Date.parse(checkout_date)
    start += 3
    start.strftime("%F")
  end
end
