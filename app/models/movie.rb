class Movie < ApplicationRecord


  validates :title, presence: true, uniqueness: true
  validates :release_date, presence: true
  validates :inventory, presence: true
  validates_numericality_of :inventory, only_integer: true, greater_than_or_equal_to: 0


  def available_inventory
    # TODO Fix this
    rentals = Rental.checked_out_by_movie(id)
    whats_left = inventory - rentals.length
    return whats_left
  end


end
