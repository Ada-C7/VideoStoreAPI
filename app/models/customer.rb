class Customer < ApplicationRecord
  has_many :rentals
  
  validates :name, presence: true
  validates :registered_at,presence: true
  validates :address, presence: true, length: {minimum: 3}
  validates :city,presence: true, format: { with: /\A[a-zA-Z]+\z/ }
  validates :state,presence: true, format: { with: /\A[a-zA-Z]+\z/}
  validates :postal_code,presence: true, numericality: true, length: { is: 5 }
  validates :phone,presence: true, format: { with: /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}\z/ }

  def increase_checkout_count
    self.movies_checked_out_count += 1
    self.save if self.valid?
  end
end
