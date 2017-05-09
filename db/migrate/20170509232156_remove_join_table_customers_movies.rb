class RemoveJoinTableCustomersMovies < ActiveRecord::Migration[5.0]
  def change
    drop_join_table :customers, :movies
  end
end
