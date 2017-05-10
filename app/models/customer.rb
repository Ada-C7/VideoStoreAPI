class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals


  def movies_checked_out
    self.rentals.select {|rental| rental.checked_out == true}.count
  end

end
