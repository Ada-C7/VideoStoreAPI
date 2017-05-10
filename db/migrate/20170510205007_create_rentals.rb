class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.date :due_date
      t.boolean :returned

      t.timestamps
    end
  end
end
