class Rental < ApplicationRecord
  belongs_to :customers
  belongs_to :movie
  validats :due_date, presence: true
  validates :customer_id, presence: true
  validates :movie_id, presence: true
end
