class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true, uniqueness: true
  validates :inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }# by default does not allow nil
end
