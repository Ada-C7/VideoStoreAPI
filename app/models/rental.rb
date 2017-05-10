class Rental < ApplicationRecord
  validates :checkout_date, presence: true
  validates_format_of :checkout_date, :with => /\d{4}\-\d{2}\-\d{2}/, :message => "Checkout date must be in the following format: yyyy/mm/dd"
  belongs_to :movie
  belongs_to :customer

  def due_date
    # checkout-date plus 3 days?
    # "2017-05-13"
  end
end
