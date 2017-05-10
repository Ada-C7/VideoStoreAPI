require "test_helper"

describe Movie do

  hash = {
    title: "test_title",
    overview: "Long Synopsis",
    release_date: "1975-06-19",
    inventory: 8
  }

  let(:movie) { Movie.new(hash) }

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

end
