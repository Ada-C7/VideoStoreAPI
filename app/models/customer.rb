class Customer < ApplicationRecord
  has_many :rentals
  validates :name, presence: true
  validates :phone, presence: true
  validates :registered_at, presence: true
  validates :postal_code, length: { is: 5 }, allow_nil: true, allow_blank: true
  validates :account_credit, numericality: {greater_than_or_equal_to: 0}
end
