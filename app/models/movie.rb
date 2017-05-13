class Movie < ApplicationRecord
  validates :title, presence: true
  validates :release_date, presence: true
  # validates :overview, presence: true
  validates :inventory, presence: true
  has_many :rentals
  # after_create :set_available_inventory

  def available?
    if self.available_inventory == 0
      return false
    else
      return true
    end
  end

  def decrease_available_inventory
    self.available_inventory = self.available_inventory - 1
    self.save
  end

  # def set_available_inventory
  #   self.available_inventory = self.inventory
  # end
end
