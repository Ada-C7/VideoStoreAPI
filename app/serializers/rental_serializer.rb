class RentalSerializer < ActiveModel::Serializer
  attributes :other_items, :customer_id, :checkout_date, :due_date, :movie_id

  def other_items
    rentals = Rental.where('due_date <= ?', Time.now)
    overdue_hash = {}
    array = []
    rentals.each do |rental|
      overdue_hash[:title] = rental.movie.title
      overdue_hash[:name]  = rental.customer.name
      overdue_hash[:postal_code] = rental.customer.postal_code
      array << overdue_hash
    end
    return array
  end

end
