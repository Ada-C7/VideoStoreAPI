class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals
  validates :name, presence: true
  validates :phone, presence: true


  def movies_checked_out_count
    count = 0
    self.rentals.each do |rental|
      if rental.returned_date.nil?
        count += 1
      end
    end
    return count
  end

end
