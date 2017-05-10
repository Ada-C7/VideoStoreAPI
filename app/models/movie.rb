class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: true
  validates :available_inventory, presence: true, numericality: true

  has_many :rentals
  has_many :customers, :through => :rentals

  def available_inventory
    # inventroy minue number of rentals containing movie's ID
  end
end
