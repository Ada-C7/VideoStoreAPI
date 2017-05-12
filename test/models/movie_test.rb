require "test_helper"

describe Movie do

  MOVIE_HASH = {
    title: "test_title",
    overview: "Long Synopsis",
    release_date: "1975-06-19",
    inventory: 8
  }

  let(:movie) { Movie.new(MOVIE_HASH) }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  it "requires a title" do
    movie.title.must_equal "test_title"
  end

  it "requires an overview" do
    movie.overview.must_equal "Long Synopsis"
  end

  it "requires a release_date" do
    movie.release_date.must_equal "1975-06-19"
  end

  it "requires an inventory" do
    movie.inventory.must_equal 8
  end

  #failure cases for validations

  it "requires a title to be valid" do
    bad_movie_title = {
      title: nil,
      overview: "Long Synopsis",
      release_date: "1975-06-19",
      inventory: 8
    }

    movie = Movie.new(bad_movie_title)
    movie.must_be :invalid?
  end

  it "requires an overview to be valid" do
    bad_movie_overview = {
      title: "test_title",
      overview: nil,
      release_date: "1975-06-19",
      inventory: 8
    }

    movie = Movie.new(bad_movie_overview)
    movie.must_be :invalid?
  end

  it "requires a release_date to be valid" do
    bad_movie_release_date = {
    title: "test_title",
    overview: "Long Synopsis",
    release_date: nil,
    inventory: 8
  }

    movie = Movie.new(bad_movie_release_date)
    movie.must_be :invalid?
  end


  it "requires an inventory to be valid" do
    bad_movie_inventory = {
    title: "test_title",
    overview: "Long Synopsis",
    release_date: "1975-06-19",
    inventory: nil
  }

    movie = Movie.new(bad_movie_inventory)
    movie.must_be :invalid?
  end

  it "requires an inventory to be an integer" do
    bad_movie_inventory_int = {
    title: "test_title",
    overview: "Long Synopsis",
    release_date: "1975-06-19",
    inventory: "string"
  }

    movie = Movie.new(bad_movie_inventory_int)
    movie.must_be :invalid?
  end

  it "requires an inventory to be an integer" do
    bad_movie_inventory_int = {
    title: "test_title",
    overview: "Long Synopsis",
    release_date: "1975-06-19",
    inventory: -10
  }

    movie = Movie.new(bad_movie_inventory_int)
    movie.must_be :invalid?
  end

  describe "check_inventory" do
    it "returns the current inventory of a particular movie" do
      rambo = movies(:rambo)
      current_inventory = rambo.check_inventory
      current_inventory.must_equal 8
    end
  end
end

#relationship testing
#ASSUMING A MOVIE HAS CUSTOMERS MOVIE.CUSTOMER
# must.be.instance_of Array
