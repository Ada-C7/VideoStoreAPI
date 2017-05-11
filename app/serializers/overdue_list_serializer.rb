class OverdueListSerializer < ActiveModel::Serializer
  attributes :customer_id, :due_date, :check_out_date,
  :title, :name, :postal_code

  def title
    object.movie.title
  end

  def name
    object.customer.name
  end

  def postal_code
    object.customer.postal_code
  end

end
