class MovieSerializer < ActiveModel::Serializer
  attributes :title, :overview, :release_date, :inventory, :available_inventory


  def available_inventory
    if object.available_inventory == 0 && no_rentals?(object)
      return object.inventory
    else
      return object.available_inventory
    end
  end

  def no_rentals?(object)
    object.rentals.each do |rental|
      return false if rental.status == "checked out"
    end
    return true
  end

  
end
