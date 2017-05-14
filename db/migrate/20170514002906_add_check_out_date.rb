class AddCheckOutDate < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :check_out, :string
  end
end
