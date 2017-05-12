class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates :due_date, presence: true

  def self.overdue
    rentals = Rental.all
    overdues = []

    rentals.each do |rental|
      due = Date.parse (rental.due_date)
      if due.past?
        overdues << rental
      end
    end
    return overdues
  end

  def info_for_overdues
    info = {
    "title" => movie.title,
    "name" => customer.name,
    "postal_code" => customer.postal_code,
    "checkout_date" => created_at
  }
   info
  end
end
