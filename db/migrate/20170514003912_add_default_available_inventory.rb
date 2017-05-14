class AddDefaultAvailableInventory < ActiveRecord::Migration[5.0]
  def change
    change_column :movies, :available_inventory, :integer, :default => 0
  end
end
