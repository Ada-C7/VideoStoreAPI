class Movie < ApplicationRecord
  before_create :default_available_inventory
  has_many :rentals
  has_many :customers, through: :rentals
  validates :title, presence: true, uniqueness: true,  uniqueness: {case_sensitive: false}
  validates :inventory, numericality: { greater_than: 0, only_integer: true }

  def get_available_inventory
    self.inventory - self.rentals.length
  end

  private
  def default_available_inventory
    self.available_inventory||= self.inventory
  end
end
