class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { greater_than: -1 }
  validates :available_inventory, presence: true, numericality: { greater_than: -1 }

  def decrease_inventory
    self.available_inventory -= 1
    self.save if self.valid?
  end
end
