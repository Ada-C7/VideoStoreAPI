class CustomerSerializer < ActiveModel::Serializer
  attributes :name, :registered_at, :address, :city, :state, :postal_code, :phone, :account_credit
end
