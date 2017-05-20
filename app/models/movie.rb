class Movie < ApplicationRecord

     validates :title, presence: true,
          uniqueness: true
     validates :overview, presence: true
     validates :release_date,
          presence: true
     validates :inventory, presence: true,
          numericality: { only_integer: true }
end
