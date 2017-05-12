class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, numericality: { only_integer: true, greater_than: -1 }
  validates :available_inventory, numericality: { only_integer: true, greater_than: -1 }

end
