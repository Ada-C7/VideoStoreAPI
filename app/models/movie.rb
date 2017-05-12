class Movie < ApplicationRecord
  after_initialize :set_available_inventory

  has_many :rentals

  validates :title, presence: true, uniqueness: true
  validates :inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }# by default does not allow nil

  def set_available_inventory
    self.available_inventory = self.inventory
  end
  
end
