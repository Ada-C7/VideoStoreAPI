class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :customer, index: true
      t.datetime :check_out
      t.datetime :check_in
      t.timestamps

    end
  end
end
