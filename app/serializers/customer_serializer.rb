class CustomerSerializer < ActiveModel::Serializer
   attributes :id, :name, :registered_at, :postal_code, :phone, :movies_checked_out

  # def movies_checked_out_count
  #   return 0
  # end
end
