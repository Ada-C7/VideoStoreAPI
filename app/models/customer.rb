class Customer < ApplicationRecord
  has_many :movies, through: :rentals

  validates :name, presence: true
  validates :registered_at, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :account_credit, presence: true
  validates :account_credit, presence: true


end
