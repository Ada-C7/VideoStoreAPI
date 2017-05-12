class Rental < ApplicationRecord
    belongs_to :movie, foreign_key: 'movie_id'
    belongs_to :customer, foreign_key: 'customer_id'

    validates :movie_id, :customer_id, :checkout_date, :due_date, presence: true
end
