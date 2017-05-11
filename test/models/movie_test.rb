require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "must be valid" do
    movie.valid?.must_equal true
  end
end
