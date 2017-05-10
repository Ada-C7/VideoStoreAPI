class Rental < ApplicationRecord
    belongs_to :movie, foreign_key: 'movie_id'
    belongs_to :customer, foreign_key: 'customer_id'
end
