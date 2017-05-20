class Customer < ApplicationRecord

     validates :name, presence: true,
          uniqueness: { scope: [:phone, :postal_code] }
     validates :registered_at, presence: true
     validates :postal_code, presence: true
     validates :phone, presence: true

end
