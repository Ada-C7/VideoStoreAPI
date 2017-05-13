class AddAvailableInventoryToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :available_inventory, :integer, :default => :inventory
  end
end
