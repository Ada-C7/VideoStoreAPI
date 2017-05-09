class Customer < ApplicationRecord
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :movies_checked_out_count, presence: true
  validates_numericality_of :movies_checked_out_count, only_integer: true, greater_than_or_equal_to: 0
  validates :account_credit, presence: true
  validates_numericality_of :account_credit
end
