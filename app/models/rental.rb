class Rental < ApplicationRecord
  validates :checkout_date, presence: true
  belongs_to :movie
  belongs_to :customer
end
