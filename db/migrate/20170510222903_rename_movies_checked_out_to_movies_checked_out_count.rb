class RenameMoviesCheckedOutToMoviesCheckedOutCount < ActiveRecord::Migration[5.0]
  def change
    rename_column :customers, :movies_checked_out, :movies_checked_out_count
  end
end
