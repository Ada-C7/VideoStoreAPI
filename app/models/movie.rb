class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true, format: { with: /\A\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])\z/, message: "must be in YYYY-MM-DD format" }
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: 0}

  def available_inventory
    return inventory - rentals.where(returned: false).length
  end

end
