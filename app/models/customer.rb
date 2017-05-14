class Customer < ApplicationRecord
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true

  has_many :movies, through: :customer_movies
  has_many :customer_movies


  def check_out#(params)
    # customer = Customer.find_by(id: params[:customer_id])
    # customer.movies_checked_out_count += 1
  end
end
