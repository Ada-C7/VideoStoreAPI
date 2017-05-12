class Customer < ApplicationRecord
  has_many :rentals

  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true

  # update later after adding rental
  def movies_checked_out_count
    return rentals.where(returned: false).length
  end

end
