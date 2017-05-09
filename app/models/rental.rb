class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  validates :due_date, presence: true
  validates :customer_id, presence: true
  validates :movie_id, presence: true
end
