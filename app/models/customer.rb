class Customer < ApplicationRecord
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :rentals_count, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  has_many :rentals

  def self.has_overdue
    #joins(:rentals).where("self.overdue?")
  end
end
