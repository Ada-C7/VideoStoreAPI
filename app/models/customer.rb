class Customer < ApplicationRecord
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :account_credit, presence: true, numericality: true
  validates :movies_checked_out, presence: true, numericality: true
end
