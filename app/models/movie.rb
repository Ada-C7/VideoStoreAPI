class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  validates :title, presence: true, uniqueness: true
  validates :inventory, numericality: { greater_than: 0, only_integer: true }

  def available_inventory
    Rails.logger.debug "ERICA rentals for #{self.title} #{self.rentals.where(returned_date = nil).inspect}"

    self.inventory - self.rentals.where(returned_date: nil).length
  end
end
