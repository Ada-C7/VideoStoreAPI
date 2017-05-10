require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "you can create a new movie" do
    movie.title = "Title"
    movie.release_date = "1983-04-15"
    movie.overview = "What"
    movie.inventory = 2
    movie.valid?.must_equal true
  end

  it "must have title present in movie" do
    movies(:flashdance).valid?.must_equal true
    no_title = Movie.new
    no_title.valid?.must_equal false
  end

  it "movie must have an inventory" do
    movie = Movie.new
    movie.title = "Princess Bride"
    movie.release_date = "1987-07-06"
    movie.save
    movie.valid?.must_equal false
    movie.errors.messages.must_include :inventory
  end

  describe "Movie available?" do
    it "If movie inventory is 0, should return false" do
      movie.inventory = 0
      movie.available?.must_equal false
    end

    it "If movie inventory is greater than 0, should return true" do
      movie.inventory = 10
      movie.available?.must_equal true
    end
    
  end

end
