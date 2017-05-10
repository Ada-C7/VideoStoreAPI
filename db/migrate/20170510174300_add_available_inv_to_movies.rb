class AddAvailableInvToMovies < ActiveRecord::Migration[5.0]

  def change
    add_column :movies, :available_inv, :integer
  end

end
