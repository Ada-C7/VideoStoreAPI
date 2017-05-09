class Customer < ApplicationRecord
  has_many :rentals
  has_and_belongs_to_many :movies
  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true
end
