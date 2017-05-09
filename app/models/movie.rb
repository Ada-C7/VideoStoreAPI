class Movie < ApplicationRecord
  # has_and_belongs_to_many :customers

  validates :title, presence: true
  validates :inventory, numericality: { only_integer: true, greater_than: -1 }
end
