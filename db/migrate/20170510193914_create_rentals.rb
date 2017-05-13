class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.date :duedate
      t.timestamps
    end
  end
end
