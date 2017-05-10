class Movie < ApplicationRecord
  has_many :customers, through: :customer_movie

  def availability
    @movie.available_inventory - 1
  end
end
