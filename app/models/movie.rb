class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :overview }
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true
  has_many :rentals

  def available_inventory
    inventory
  end
end
