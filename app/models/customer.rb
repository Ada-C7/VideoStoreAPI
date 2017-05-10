class Customer < ApplicationRecord
  has_many :movies, through: :rentals
  has_many :rentals
end
