require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  describe "Movie relationships" do
    #####
    # Need to change relationships
    #####
    # it "A movies belongs to a customer" do
    #   movie = movies(:one)
    #   movie.must_respond_to :customer
    # end
  end

  describe "Movie validations" do
    it "Is valid with a title and inventory greater than -1" do
      movie = movies(:two)
      movie.valid?.must_equal true
    end

    it "Is not valid without a title" do
      movie = movies(:one)
      movie.title = nil
      movie.valid?.must_equal false
    end

    it "Is not valid with a negative inventory amount" do
      movie = movies(:one)
      movie.inventory = -2
      movie.valid?.must_equal false
    end
  end
end
