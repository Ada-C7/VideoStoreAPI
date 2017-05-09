class Movie < ApplicationRecord
  has_many :rentals
  has_and_belongs_to_many :customer
  validates :title, presence: true, uniqueness: true
end
