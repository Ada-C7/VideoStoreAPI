class Movie < ApplicationRecord
  validates :title, uniqueness: true
  validates :inventory, numericality: { greater_than_or_equal_to: 0 }
end
