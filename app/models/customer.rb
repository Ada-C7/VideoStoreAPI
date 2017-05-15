class Customer < ApplicationRecord
  # validates :id, presence: true
  # validates :name, presence: true
  # validates :registered_at, presence: true
  # validates :name, presence: true
  # validates :postal_code, presence: true
  # validates :phone, presence: true
  # validates :movies_checked_out_count, presence: true

  has_many :movies, through: :customer_movies
  has_many :customer_movies
end
