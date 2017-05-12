JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  Movie.create!(movie)
end

Rental.create (
  {
      movie: Movie.first,
      customer: Customer.first
  })

Rental.create (
  {
      movie: Movie.first,
      customer: Customer.last,
      due_date: Chronic.parse('yesterday')

  }
)
