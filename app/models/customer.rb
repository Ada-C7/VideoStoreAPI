class Customer < ApplicationRecord
  # has_and_belongs_to_many :movies
  has_many :rentals

  validates :name, presence: true
  validates :phone, presence: true
end
