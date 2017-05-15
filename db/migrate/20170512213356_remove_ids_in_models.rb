class RemoveIdsInModels < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :movie_id
    remove_column :movies, :customer_id
  end
end
