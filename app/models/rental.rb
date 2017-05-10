class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates :due_date, presence: true
end
