JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  new_customer = Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  new_movie = Movie.create!(movie)
end
