class Movie < ApplicationRecord
    has_many :customers, through: :rentals
    has_many :rentals

    before_validation(on: :create) do
        Movie.update_all('available_inventory = inventory')
    end

    validates :title, presence: true
    validates :inventory, numericality: { greater_than_or_equal_to: 0 }
end
