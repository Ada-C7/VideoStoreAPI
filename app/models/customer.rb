class Customer < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :registered_at, presence: true
end
