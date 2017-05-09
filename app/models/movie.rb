class Movie < ApplicationRecord
  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true, format: { with: /\A\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])\z/, message: "must be in YYYY-MM-DD format" }
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: 0}

end
