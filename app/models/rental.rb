class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  validates :due_date, presence: true
  validates :customer_id, presence: true
  validates :movie_id, presence: true

  def checkout_date
    return self.created_at.to_date
  end

  def title
    return Movie.find_by(id: self.movie_id).title
  end

  def name
    return Customer.find_by(id: self.customer_id).name
  end

  def postal_code
    return Customer.find_by(id: self.customer_id).postal_code
  end


end
