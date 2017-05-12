class RentalSerializer < ActiveModel::Serializer
  attributes :title, :name, :postal_code, :checkout_date, :due_date, 

  def title
    object.movie.title
  end

  def customer_id
    object.customer.id
  end

  def name
    object.customer.name
  end

  def postal_code
    object.customer.postal_code
  end

end
