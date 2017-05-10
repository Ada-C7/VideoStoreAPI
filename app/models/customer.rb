class Customer < ApplicationRecord
  validates :name, format: { with: /\A[a-zA-Z +]+\z/, message: "letters only" }
  validates :phone, format: { with: /\([0-9][0-9][0-9]\) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]/, message: "phone number must be of the  NANP number format  (xxx) xxx-xxxx "}
  validates :address, presence: true
  validates :registered_at, presence: true

  def movies_checked_out_count
    return 0
  end

end
