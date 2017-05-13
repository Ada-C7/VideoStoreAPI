class Movie < ApplicationRecord

  validates :title, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true }
  validates :release_date, presence: true

  has_many :rentals


  def adjust_inventory_in
    self.available_inventory += 1
    self.save
  end

  def adjust_inventory_out
    self.available_inventory -= 1
    self.save
  end

end
