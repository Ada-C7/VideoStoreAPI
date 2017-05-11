class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :release_date, :inventory, :available_inventory

  has_one :customer

  def available_inventory
  end

  #define methods for other data we want to include in the JSON(like to call a method in the model)
  # def fuzzy
  #   "I'm fuzzy"
  # end

  # def human_name
  #   human.name
  # end

end
