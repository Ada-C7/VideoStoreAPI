class MovieSerializer < ActiveModel::Serializer
  attributes :title, :overview, :release_date, :inventory, :available_inventory

  def available_inventory
    return inventory
  end
end
