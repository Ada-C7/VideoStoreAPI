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

  #class end
end
