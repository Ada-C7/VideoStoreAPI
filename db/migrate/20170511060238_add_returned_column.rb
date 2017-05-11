class AddReturnedColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :rentals, :check_in, :checkin_date

    add_column :rentals, :returned, :boolean, default: false
  end
end
