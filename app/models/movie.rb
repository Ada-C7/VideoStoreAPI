class Movie < ApplicationRecord
  has_many :customers, through: :customer_movie
  has_many :customer_movies

  def availability
    # @movie.available_inventory - 1
  end
end
