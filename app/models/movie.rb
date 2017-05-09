class Movie < ApplicationRecord
  validates :title, presence:
  validates :release_date, presence:
end
