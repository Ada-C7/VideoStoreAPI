class AddCheckinDateColumnToRentals < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :checkin_date, :string
  end
end
