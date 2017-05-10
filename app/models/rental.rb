class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates :due_date, presence: true


  def self.checked_out(movie_id)
    if Movie.find_by_id(movie_id)
      rentals = self.where(movie_id: movie_id)
      return  rentals.where(check_in: nil)
    else 
      return nil
    end
  end
end
