class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :due_date, presence: true
  validates :movie_id, presence: true, numericality: true
  validates :customer_id, presence: true, numericality: true

  def overdue
    Date.parse(self.due_date).past? && self.returned == false ? true : false
  end

  def title
    self.movie.title
  end

  def name
    self.customer.name
  end

  def postal_code
    self.customer.postal_code
  end

  def checkout_date
    self.created_at
  end
end
