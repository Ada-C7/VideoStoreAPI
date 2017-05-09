class Movie < ApplicationRecord
  validates :title, presence: true
  validates_uniqueness_of :title, scope: :release_date
  validates :inventory, presence: true
  validates :release_date, presence: true
end
