class MovieSerializer < ActiveModel::Serializer
  attributes :title, :release_date, :available_inventory, :overview, :inventory
end
