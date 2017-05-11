class CustomerSerializer < ActiveModel::Serializer
  attributes :name, :movies_checked_out_count, :phone, :overdue_date
end
