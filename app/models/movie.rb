class Movie < ApplicationRecord
    has_many :customers, through: :rentals
    has_many :rentals
end
