JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  mov = Movie.create!(movie)
  mov.available_inventory = mov.inventory
  mov.save
end
