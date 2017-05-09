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
  end
end
