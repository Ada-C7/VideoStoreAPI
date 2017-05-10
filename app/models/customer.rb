class Customer < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true

  # update later after adding rental
  def movies_checked_out_count
    return 0
  end

end
