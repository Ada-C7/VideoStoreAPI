class RentalSerializer < ActiveModel::Serializer
  attributes :customer_id, :checkout_date, :due_date, :title, :name, :postal_code

  def title
    return object.movie.title
  end
  def name
    return object.customer.name
  end
  def postal_code
    return object.customer.postal_code
  end
end
