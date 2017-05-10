class RentalSerializer < ActiveModel::Serializer
  attributes :customer_id, :due_date, :checkout_date
  has_one :movie
  has_one :customer, only: [:postal_code]

end
