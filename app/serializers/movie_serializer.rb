class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :overview, :release_date, :inventory, :available_inventory

  def available_inventory
    object.inventory
  end
end
