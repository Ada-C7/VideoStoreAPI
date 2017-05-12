class Movie < ApplicationRecord
  validates :title, presence: true
  validates_uniqueness_of :title, scope: :release_date
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :release_date, presence: true

  has_many :rentals

  def available_inventory
    #should subtract from the inventory the number of copies out in active rentals (checkin_date = nil)
    rentals = Rental.where(movie_id: self.id, checkin_date: nil)
    return self.inventory - rentals.size
  end

end
