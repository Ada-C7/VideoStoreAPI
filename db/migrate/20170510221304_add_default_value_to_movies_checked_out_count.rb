class AddDefaultValueToMoviesCheckedOutCount < ActiveRecord::Migration[5.0]
  def change
    change_column :customers, :movies_checked_out_count, :integer, default: 0
  end
end
