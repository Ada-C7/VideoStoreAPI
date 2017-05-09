class Movie < ApplicationRecord
  validates :title, presence: true
  validates :release_date, presence: true
  # validates :overview, presence: true
  # validates_numericality_of :inventory, greater_than: 0
end
