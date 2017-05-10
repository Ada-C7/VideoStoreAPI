class CreateRentals < ActiveRecord::Migration[5.0]
    def change
        create_table :rentals do |t|
            t.integer :movie_id
            t.integer :customer_id
            t.datetime :checkout_date
            t.datetime :due_date

            t.timestamps
        end
    end
end
