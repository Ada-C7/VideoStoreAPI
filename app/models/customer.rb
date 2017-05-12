class Customer < ApplicationRecord
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :account_credit, presence: true, numericality: true

  has_many :rentals
  has_many :movies, :through => :rentals

  def movies_checked_out_count
    return Rental.where(customer_id: self.id).count
  end
end
