class RemoveMoviesCheckedOutFromDb < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :movies_checked_out
  end
end
