require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  describe "Movie relationships" do
    it "Movies can have many rentals" do
      movie = movies(:two)
      movie.rentals.must_include rentals(:one)
    end
  end

  describe "Movie validations" do
    it "Is valid with a title and inventory greater than -1" do
      movie = movies(:two)
      movie.valid?.must_equal true
    end

    REQUIRED_FIELDS = %w(title overview release_date)
    
    REQUIRED_FIELDS.each do |field|
      it "Customer is not valid when #{field} is not present" do
        movie.valid?.must_equal false
        movie.errors.messages.must_include field.to_sym
      end
    end

    it "Is not valid with a negative inventory amount or available_inventory" do
      movie = movies(:one)
      movie.inventory = -2
      movie.valid?.must_equal false

      movie.available_inventory = -1
      movie.valid?.must_equal false
    end
  end
end
