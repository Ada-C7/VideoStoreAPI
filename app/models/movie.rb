class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :inventory, numericality: { only_integer: true, greater_than: -1 }
end
