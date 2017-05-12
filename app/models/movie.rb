class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true, format: { with: /\A(19|20)\d{2}\z/ }
  validates :inventory, presence: true, numericality: { greater_than: -1 }
end
