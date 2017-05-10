class Movie < ApplicationRecord
  validates :title, presence: true
  validates :release_date, presence: true
  # validates :overview, presence: true
  validates :inventory, presence: true
  has_many :rentals


  def available?
    if self.inventory == 0
      return false
    else
      return true
    end

  end
end
