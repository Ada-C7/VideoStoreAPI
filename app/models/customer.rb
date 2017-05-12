class Customer < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true
  validates :postal_code, length: { is: 5 }, if: :postal_code
  has_many :rentals


  # def validate!
  #   errors.add(:name, :blank, message: "Customer does not exist!") if self.nil?
  # end
end
