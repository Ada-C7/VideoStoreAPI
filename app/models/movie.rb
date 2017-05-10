class Movie < ApplicationRecord
    has_many :customers, through: :rentals
    has_many :rentals
    # 
    # def return_movie_title
end
