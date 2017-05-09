class Movie < ApplicationRecord
  has_many :customers, through: :customer_movie
end
