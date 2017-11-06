class Customer < ApplicationRecord
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :account_credit, presence: true
  validates_numericality_of :account_credit


  def movies_checked_out_count
    # TODO: Fix this
    rentals = Rental.checked_out_by_customer(id)
    return rentals.count
  end
end
