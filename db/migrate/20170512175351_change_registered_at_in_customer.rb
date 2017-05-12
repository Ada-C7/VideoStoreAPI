class ChangeRegisteredAtInCustomer < ActiveRecord::Migration[5.0]
  def change
    change_column :customers, :registered_at, 'date USING CAST(registered_at AS date)'
  end
end
