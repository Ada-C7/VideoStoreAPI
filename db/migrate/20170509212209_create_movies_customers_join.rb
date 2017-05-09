class CreateMoviesCustomersJoin < ActiveRecord::Migration[5.0]
  def change
    create_table :movies_customers_joins do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :customer, index: true
      t.timestamps
    end
  end
end
