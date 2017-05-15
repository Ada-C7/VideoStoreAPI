class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :overview
      t.string :release_date
      t.integer :inventory
      t.belongs_to :customer

      t.timestamps
    end
  end
end
