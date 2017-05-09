JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
   c = Customer.new
   c.name = customer["name"]
   c.registered_at = customer["registered_at"]
   c.address = customer["address"]
   c.city = customer["city"]
   c.state = customer["state"]
   c.postal_code = customer["postal_code"]
   c.phone = customer["phone"]
   c.save
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  Movie.create!(movie)
end
