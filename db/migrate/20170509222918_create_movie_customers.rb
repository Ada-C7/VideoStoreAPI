class CreateMovieCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_customers do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :customer, index: true
      t.string :checkout_date
      t.string :due_date
      t.timestamps
    end
  end
end
