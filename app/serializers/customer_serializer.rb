class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :movies_checked_out_count, :phone, :registered_at, :postal_code#, :overdue_date
  attribute :overdue_date, if: -> {object.overdue_date != nil}
end
