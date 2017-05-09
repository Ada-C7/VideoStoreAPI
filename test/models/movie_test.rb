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
    it "returns the inventory" do
      # TODO create relationships :) and re-write method :) :)
      movie = Movie.all.first
      movie.available_inventory.must_equal movie.inventory
    end
  end
end
