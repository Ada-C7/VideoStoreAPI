class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals
  validates :name, presence: true
  validates :name, format: { with: /\A[a-zA-Z + ]+\z/, message: "letters only" }
  validates :phone, presence: true
  validates :phone, format: { with: /\([0-9]{3}\) [0-9]{3}-[0-9]{4}/, message: "phone number must be of the  NANP number format  (nnn) nnn-nnnn "}
  validates :postal_code, presence: true
  validates :postal_code, format: { with: /[0-9]{5}/, message: "postal code must be of the of the format nnnnn "}
  validates :registered_at, presence: true

  def movies_checked_out_count
    return 0
  end

end
