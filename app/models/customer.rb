class Customer < ApplicationRecord
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "letters only"}
  validates :address, presence: true
  validates :phone, presence: true
  validates :registered_at, presence: true
end
