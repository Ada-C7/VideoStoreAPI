class Customer < ApplicationRecord
  # has_and_belongs_to_many :movies

  validates :name, presence: true
  validates :phone, presence: true
end
