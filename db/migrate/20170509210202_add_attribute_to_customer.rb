class AddAttributeToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :registered_at, :string
  end
end
