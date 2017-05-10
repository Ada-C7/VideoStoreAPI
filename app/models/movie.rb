class Movie < ApplicationRecord
  after_initialize :set_available_inventory_default
  validates :title, presence: true
  validates :release_date, presence: true
  validates :overview, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :available_inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :rentals


  private

  def set_available_inventory_default
    self.available_inventory = self.inventory
  end
end
