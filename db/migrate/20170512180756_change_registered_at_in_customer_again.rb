class ChangeRegisteredAtInCustomerAgain < ActiveRecord::Migration[5.0]
  def change
    change_column :customers, :registered_at, 'timestamp USING CAST(registered_at AS timestamp)'
  end
end
