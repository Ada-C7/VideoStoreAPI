class RentalSerializer < ActiveModel::Serializer
  attributes :title, :customer_id, :name, :postal_code, :due_date, :checkout_date


  def title
    object.movie.title
  end

  def name
    object.customer.name
  end

  def postal_code
    object.customer.postal_code
  end

  def checkout_date
    object.created_at.strftime("%Y-%m-%d")
  end
end
