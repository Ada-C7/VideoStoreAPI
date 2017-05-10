class AddMoviesCheckedOutCountToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :movies_checked_out, :integer, :default => 0
  end
end
