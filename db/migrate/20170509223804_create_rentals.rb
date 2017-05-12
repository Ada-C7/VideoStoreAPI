class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
        t.string :due_date
        t.belongs_to :movie
        t.belongs_to :customer

      t.timestamps
    end
  end
end
