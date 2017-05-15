class DeleteColumnsInModels < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :movies_checked_out_count
    remove_column :movies, :available_inventory
  end
end
