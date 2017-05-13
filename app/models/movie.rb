class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence:true
  validates :title, format:{ with: /([a-z]{1,})/,
    message: "incorrect title format" }

  validates :release_date, presence:true
validates :release_date, format: {with: /\d{4}\/\d{2}\/\d{2}/, message: "Not a valid date"}
  validates :overview, presence:true
  validates :overview, format:{ with: /([a-z]{1,})/,  message: "Must be a string" }

  validates :inventory, presence:true
  validates :inventory, numericality:true


  def available_inventory
    return self.inventory
  end

end
