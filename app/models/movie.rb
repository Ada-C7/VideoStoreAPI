class Movie < ApplicationRecord
    has_many :rentals
    has_many :customers, through: :rentals

    validates :title, presence: true
    validates :release_date, presence: true
    validates :inventory, presence: true, numericality: { only_integer: true }
    validates :available_inventory, presence: true, numericality: { only_integer: true, less_than_or_equal_to: :inventory }
end
