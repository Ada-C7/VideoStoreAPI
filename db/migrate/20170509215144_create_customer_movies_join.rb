class CreateCustomerMoviesJoin < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_movies_joins do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :movie, index: true
    end
  end
end
