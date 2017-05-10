class Customer < ApplicationRecord
    has_many :rentals
    has_many :movies, through: :rentals

    validates :name, presence: true
    validates :registered_at, presence: true
    validates :phone, presence: true

    def movies_checked_out_count
        movies.length
    end

end
