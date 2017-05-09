class Movie < ApplicationRecord
  before_create :set_available_inventory_default

  validates :title, presence: true, uniqueness: true
  validates :release_date, presence: true
  validates :inventory, presence: true
  validates_numericality_of :inventory, only_integer: true, greater_than_or_equal_to: 0

  private

  def set_available_inventory_default
    self.available_inventory = self.inventory
  end
end
