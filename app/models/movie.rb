class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :release_date, presence: true
  validates :inventory, presence: true
  validates_numericality_of :inventory, only_integer: true, greater_than_or_equal_to: 0
end
