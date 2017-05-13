class RentalSerializer < ActiveModel::Serializer
  attributes :title, :customer_id, :name, :due_date, :postal_code, :checkout_date, :due_date
end
