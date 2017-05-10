class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  def available_inventory
    rentals = self.rentals.select do |rental|
      rental.checked_out == true
    end
    return (self.inventory - rentals.length)
  end
end
