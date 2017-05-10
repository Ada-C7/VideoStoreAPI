class Rental < ApplicationRecord
  belongs_to :customers
  belongs_to :movies
end
