class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true, uniqueness: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def available_inventory
    rentals = Rental.where(returned: false, movie_id: id)
    return inventory - rentals.count
  end

end
