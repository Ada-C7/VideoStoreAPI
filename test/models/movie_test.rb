
require "test_helper"

describe Movie do
  describe "validations" do
    it "creates product with title" do
      movie = Movie.create(title: "The Color Purple")
      movie.errors.messages.wont_include :title
    end

    it "is invalid without a title" do
      movie = Movie.create(inventory: 3)
      movie.valid?.must_equal false
      movie.errors.messages.must_include :title
    end

    it "creates product with inventory > 0" do
      movie = Movie.create(inventory: 5)
      movie.errors.messages.wont_include :inventory
    end

    it "is invalid if inventory is < 0 " do
      movie = Movie.create(inventory: -5)
      movie.valid?.must_equal false
      movie.errors.messages.must_include :title
    end

    it "does not accept a duplicate title " do
      Movie.create(title: "Movie", inventory: 1)
      duplicate = Movie.new(title: "Movie", inventory: 1)
      duplicate.save.must_equal false
      duplicate.errors.messages.must_include :title
    end
  end

  describe "relationships" do
    it "can have multiple rentals" do
      movie = movies(:mermaid)
      movie.rentals.count.must_equal 2
      movie.rentals.each { |rental| rental.must_be_kind_of Rental }
    end

    it "can have multiple customers through rentals" do
      movie = movies(:mermaid)
      movie.customers.count.must_equal 2
      movie.customers.each { |customer| customer.must_be_kind_of Customer }
    end

    it "returns an empty rentals array if it has not been rented" do
      movie = movies(:dark)
      movie.rentals.count.must_equal 0
      movie.rentals.must_equal []
    end

    it "returns an empty customer array if it has not been rented" do
      movie = movies(:dark)
      movie.customers.count.must_equal 0
      movie.customers.must_equal []
    end
  end

  describe "get_available_inventory" do
    it "returns the original inventory if no copies are rented checkouts" do
      movies(:dark).get_available_inventory.must_equal 10
    end

    it "returns the original inventory minus number that are checked out if the number is zero" do
      available = movies(:mermaid).inventory - rentals.movies.where()
      movies(:).get_available_inventory.must_equal 10
    end
  end
end
