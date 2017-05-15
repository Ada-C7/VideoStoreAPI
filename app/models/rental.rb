class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates :customer_id, presence: true
  validates :movie_id, presence: true
  validates :due_date, presence: true
  
end
