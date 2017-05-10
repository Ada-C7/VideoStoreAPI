class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals
  validates :name, presence: true
  validates :phone, presence: true


  # def movies_checked_out_count
  #
  #   self.rentals
    # if rentals.due_date 
    # if @rentals.nil?
    #   rentals_count = 0
    # else
    #   rentals_count = rentals.count
    # end
    # return rentals.count
  # end
end
