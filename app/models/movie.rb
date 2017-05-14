class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  validates :title, presence: true, uniqueness: true,  uniqueness: {case_sensitive: false}
  validates :inventory, numericality: { greater_than: 0, only_integer: true }

  def available_inventory
    Rails.logger.debug "rentals for #{self.title} #{self.rentals.where("returned_date = null").inspect}"

    self.inventory - self.rentals.where(returned_date = nil).length
  end
end
