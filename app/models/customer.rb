class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  validates :name, presence: true
  validates :phone, presence: true
  validates :postal_code, length: { is: 5 }

  # scope :movies_checked_out_count, -> { movies.count }

  def movies_checked_out_count
    movies.count
  end

end
