class DetailedMovieSerializer < ActiveModel::Serializer
    attributes :title, :release_date, :overview, :inventory, :available_inventory

    def available_inventory
      object.available_inventory
    end

end
