require "test_helper"

describe Movie do
  describe "validations" do
    it "Movie is invalid without a title" do
      movie = Movie.new
      result = movie.valid?
      result.must_equal false

      movie.errors.messages.must_include :title
    end

    it "Creates Movie with title" do
      movie = Movie.create(title: "SofiaMovie")
      movie.errors.messages.wont_include :title
    end

    it "Movie is invalid without an empty title field" do
      movie = Movie.new(title: "")
      result = movie.valid?
      result.must_equal false

      movie.errors.messages.must_include :title
    end

    it "Movie is invalid without a inventory" do
      movie = Movie.new
      result = movie.valid?
      result.must_equal false

      movie.errors.messages.must_include :inventory
    end

    it "Creates Movie with inventory" do
      movie = Movie.create(inventory: "Sofia")
      movie.errors.messages.wont_include :inventory
    end

    it "Movie is invalid without an empty inventory field" do
      movie = Movie.new(inventory: "")
      result = movie.valid?
      result.must_equal false

      movie.errors.messages.must_include :inventory
    end

    describe "relationships" do
      it "has a customer" do
        movie = movies(:lalaland)
        movie.must_respond_to :customers
        movie.customers.each do |customer|
          customer.must_be_kind_of Customer
        end
      end

      it "should have many customers" do
        movie = movies(:titanic)
        movie.customers.count.must_equal 2
      end

    end
  end
end
