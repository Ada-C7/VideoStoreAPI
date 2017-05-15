class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count
  attribute :number_of_overdues, if: -> {object.number_of_overdues != nil}
  # attribute :due_date, if: -> {object.due_date != nil}
end
