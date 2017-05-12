class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :release_date, :inventory, :overview, :available_inventory

  # has_many :customers

  #define methods for other data we want to include in the JSON(like to call a method in the model)
  def available_inventory
    object.check_inventory
  end

  # def human_name
  #   human.name
  # end

end
