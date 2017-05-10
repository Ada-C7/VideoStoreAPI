class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.string :checkout_date
      t.string :due_date

      t.timestamps
    end

    add_reference :rentals, :movie, foreign_key: true
    add_reference :rentals, :customer, foreign_key: true
  end
end
