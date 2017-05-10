class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates :due_date, presence: true


  def self.checked_out_by_movie(movie_id)
    if Movie.find_by_id(movie_id)
      rentals = self.where(movie_id: movie_id)
      return  rentals.where(check_in: nil)
    else
      return nil
    end
  end

  def self.checked_out_by_customer(customer_id)
    if Customer.find_by_id(customer_id)
      rentals = self.where(customer_id: customer_id)
      return  rentals.where(check_in: nil)
    else
      return nil
    end
  end
end
