require "test_helper"

describe Movie do
  describe "validations" do
    it "won't create a movie without parameters" do
      required_attributes = [ :title, :overview, :release_date, :inventory ]
      movie = Movie.new
      movie.valid?.must_equal false
      required_attributes.each do |attribute|
        movie.errors.messages.must_include attribute
      end
    end

    it "can create a movie with valid parameters" do
      movies(:star_wars).valid?.must_equal true
    end

    it "allows duplicate title if overviews are different" do
      movie_1 = movies(:star_wars)
      movie_2 = Movie.new(title: movie_1.title, overview: "Not the same", release_date: movie_1.release_date, inventory: movie_1.inventory)

      movie_2.valid?.must_equal true
    end

    it "doesn't allow a duplicate title and overview" do
      movie_1 = movies(:star_wars)
      movie_2 = movie_1.dup
      movie_2.valid?.must_equal false

      movie_2.errors.messages.must_include :title
    end
  end

  describe "available_inventory" do
    it "returns the correct available inventory when there are copies checked out" do
      # We expect 19 available because there is a total inventory of 20
      # and there is one copy checked out in the rentals fixtures
      movies(:star_wars).available_inventory.must_equal 19
    end

    it "returns the inventory when no copies are checked out" do
      movies(:no_rentals).available_inventory.must_equal movies(:no_rentals).inventory
    end
  end
end
