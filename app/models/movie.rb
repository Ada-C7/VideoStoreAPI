class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: true

  has_many :rentals
  has_many :customers, :through => :rentals

  def available_inventory
    num_checked_out = calc_num_checked_out

    return available_inventory - num_checked_out
  end

  def calc_num_checked_out
    # created a method to calculate the number of checked out
    # movies by finding all rental instances with the movie's
    # id where the returned value is false
    return 1
  end
end
