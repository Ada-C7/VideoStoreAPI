require "test_helper"

describe Movie do
  describe "relations" do
    it "has a list of customers" do
      jaws = movies(:jaws)
      jaws.must_respond_to :customers
      jaws.customers.each do |customer|
        customer.must_be_kind_of Customer
      end
    end

    it "has a list of rentals" do
      jaws = movies(:jaws)
      jaws.must_respond_to :rentals
      jaws.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end

  describe "validations" do
    it "can be created with all required attributes" do
      Movie.create!(
      title: 'test title',
      inventory: 8
      )
    end

    it "requires a title" do
      movie = Movie.new
      movie.valid?.must_equal false
      movie.errors.messages.must_include :title
    end

    it "requires a unique title" do
      duplicate_movie = Movie.new(title: "Jaws", inventory: 8)
      duplicate_movie.valid?.must_equal false
      duplicate_movie.errors.messages.must_include :title
    end

    it "requires an inventory" do
      movie = Movie.new
      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
    end

    it "requires the inventory to be an integer" do
      movie = Movie.new(inventory: "e")
      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
    end

    it "requires the inventory to be positive" do
      movie = Movie.new(inventory: -4)
      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
    end

    it "allows an inventory of zero" do
      Movie.create!(inventory: 0, title: "test title")
    end
  end
end
