class Movie < ApplicationRecord
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}

def check_inventory
  # if
  #calculate
  #inventory - checked out
  # return available_inventory
  return inventory
end

end
