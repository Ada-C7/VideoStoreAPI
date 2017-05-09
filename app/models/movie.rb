class Movie < ApplicationRecord
  validates :title, presence:true
  validates :title, format:{ with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
  validates :release_date, presence:true
  # Write in the format validation
  validates :overview, presence:true
  validates :overview, format:{ with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }

  validates :inventory, presence:true
  validates :inventory, numericality:true

end
