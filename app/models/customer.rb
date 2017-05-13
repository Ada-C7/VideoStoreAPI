class Customer < ApplicationRecord
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :phone, presence: true
  validates :postal_code, presence: true
  validates :movies_checked_out_count, presence: true, numericality: { only_integer: true}

  def adjust_inventory_in
    self.movies_checked_out_count += 1
    self.save
  end

  def adjust_inventory_out
    self.movies_checked_out_count -= 1
    self.save
  end

end
