class Rental < ApplicationRecord

  belongs_to :movie
  belongs_to :customer, counter_cache: true

end
