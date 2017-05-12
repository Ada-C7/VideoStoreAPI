class MovieSerializer < ActiveModel::Serializer
  attributes :title, :release_date, :overview, :inventory, :available_inventory
end
