# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


raw_data = File.read(Rails.root.join("db", "seeds", "movies.json"))
movies = JSON.parse(raw_data)

movies.each do |movie|
  movie["available_inventory"] = movie["inventory"]
  Movie.create(movie)
end

raw_data = File.read( Rails.root.join('db', 'seeds', 'customers.json'))
customers = JSON.parse(raw_data)

customers.each do |customer|
  customer.delete('account_credit')
  Customer.create(customer)
end
