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

end
