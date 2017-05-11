class CustomerSerializer < ActiveModel::Serializer
  attributes :name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit, :movie_id, :movies_checked_out_count
end
