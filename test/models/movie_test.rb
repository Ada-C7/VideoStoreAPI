require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  describe "Make a new movie" do

    hash = {
      title: "test_title",
      overview: "Long Synopsis",
      release_date: "1975-06-19",
      inventory: 8
    }

    it "takes a title" do
      movie = Movie.new(hash)
      movie.title.must_equal "test_title"
    end

    it "takes an overview" do
      movie = Movie.new(hash)
      movie.overview.must_equal "Long Synopsis"
    end

    it "take a release_date" do
      movie = Movie.new(hash)
      movie.release_date.must_equal "1975-06-19"
    end

    it "takes an inventory" do
      movie = Movie.new(hash)
      movie.inventory.must_equal 8
    end

  end

end
