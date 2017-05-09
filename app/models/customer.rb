class Customer < ApplicationRecord
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :phone, presence: true
  validates :postal_code, presence: true
  validates :movies_checked_out_count, presence: true, numericality: { only_integer: true}
end
