class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: true

  has_many :rentals
  has_many :customers, :through => :rentals

  def available_inventory
    number_of_movies = self.inventory
    checked_out = Rental.where(movie_id: self.id, returned: false).count
    return number_of_movies - checked_out
  end

end
