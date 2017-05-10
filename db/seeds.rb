JSON.parse(File.read('db/seeds/customers.json')).each do | customer |
  Customer.create!(customer.except('address', 'city', 'state', 'account_credit' ))
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  Movie.create!(movie.except())
end
