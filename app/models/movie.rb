class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  validates :title, presence: true, uniqueness: true,  uniqueness: {case_sensitive: false}
  validates :inventory, numericality: { greater_than: 0, only_integer: true }
end
