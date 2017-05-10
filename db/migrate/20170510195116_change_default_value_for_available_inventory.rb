class ChangeDefaultValueForAvailableInventory < ActiveRecord::Migration[5.0]
  def change
    change_column :movies, :available_inventory, :integer, default: :inventory
  end
end
