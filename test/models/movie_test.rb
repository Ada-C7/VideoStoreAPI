require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  describe "validations" do
    it "must create a new movie with good info" do
      movie.title = "Movie"
      movie.overview = "Great"
      movie.release_date = "1987-11-17"
      movie.inventory = 1
      movie.save!
      movie.valid?.must_equal true
    end

    it "is invalid without a title" do
      movie.overview = "Great"
      movie.release_date = "1987-11-17"
      movie.inventory = 1
      # movie.save!
      movie.valid?.must_equal false
    end
  end
end
