class Rental < ApplicationRecord

  has_many :movies
  belongs_to :customer

  validates :customer_id, presence: true
  validates :movie_id, presence: true
  validates :due_date, presence: true


end
