class Movie < ApplicationRecord
  has_many :rentals
  validates :title, presence: true, uniqueness: true
end
