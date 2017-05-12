class Customer < ApplicationRecord
    has_many :movies, through: :rentals
    has_many :rentals

    validates :name, :registered_at, presence: true
end
