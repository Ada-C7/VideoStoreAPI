class Customer < ApplicationRecord
  has_many :movies, through: :customer_movie
end
