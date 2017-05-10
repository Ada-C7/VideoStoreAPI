class Customer < ApplicationRecord
    has_many :movies, through: :movies
    has_many :rentals
end
