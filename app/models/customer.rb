class Customer < ApplicationRecord

  # has_many :movies

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :account_credit, presence: true, numericality: { greater_than_or_equal_to: 0 }



  validates :name, uniqueness: { scope: [:address, :city, :state, :postal_code, :phone] }

  def movies_checked_out_count
    #rentals with this customer id and checkin_date = nil
    rentals = Rental.where(customer_id: self.id, checkin_date: nil)
    return rentals.size
  end

end
