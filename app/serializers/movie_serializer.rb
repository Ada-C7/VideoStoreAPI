class MovieSerializer < ActiveModel::Serializer
  attributes :title, :release_date, :overview, :inventory, :available_inventory

  # has_many :customers
end
