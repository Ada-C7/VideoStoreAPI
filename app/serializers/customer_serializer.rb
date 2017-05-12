class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count

  def movies_checked_out_count
    object.movies_count
  end
end
