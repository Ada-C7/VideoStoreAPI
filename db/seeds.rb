JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  new_customer = Customer.create!(customer)
  # new_customer[:movies_checked_out_count] = 0
  # new_customer.save
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  new_movie = Movie.create!(movie)
  # new_movie[:available_inventory] = new_movie.inventory
  # new_movie.save
end
