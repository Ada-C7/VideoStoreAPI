class CreateMoviesCustomersJoin < ActiveRecord::Migration[5.0]
  def change
    create_join_table :customers, :movies do |t|
      t.index :customer_id
      t.index :movie_id
      t.timestamps
    end
  end
end
