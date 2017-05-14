class DeleteAvailableColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :available_inventory
  end
end
