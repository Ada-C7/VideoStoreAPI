class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.string :title
      t.integer :customer_id
      t.string :name
      t.string :postal_code
      t.string :checkout_date
      t.string :due_date

      t.timestamps
    end
  end
end
