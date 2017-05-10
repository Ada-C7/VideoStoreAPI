class RentalSerializer < ActiveModel::Serializer
  attributes :movie_title, :customer_name, :due_date, :returned_date

  def movie_title
    return Movie.find_by(id: object.movie_id).title
  end

  def customer_name
    return Customer.find_by(id: object.customer_id).name
  end
end
