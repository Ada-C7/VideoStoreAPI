class CreateCustomerMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_movies do |t|
      t.belongs_to :movie
      t.belongs_to :customer
      
      t.timestamps
    end
  end
end
