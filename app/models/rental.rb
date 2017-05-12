class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def checked_out?(title)
  end

end
