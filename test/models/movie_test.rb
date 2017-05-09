require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "requires a title to create" do
    movie.valid?.must_equal false
  end

  it "title must be unique" do
    bad_movie = Movie.new
    bad_movie.title = "American Beauty"

    bad_movie.save.must_equal false
  end

  it "must be able to create w/title" do
    movie.title = "My Movie"

    movie.valid?.must_equal true
  end

  it "can have many customers associated with it" do
    test_movie = movies(:one)
    test_movie.customer_ids = [customers(:one).id]
    test_movie.save.must_equal true
  end

end
