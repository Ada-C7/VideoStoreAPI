class TryingAgainWithDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :movies, :available_inventory, :inventory
  end
end
