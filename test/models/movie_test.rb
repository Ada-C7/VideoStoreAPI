require "test_helper"

describe Movie do
  describe "validations" do

    it "creates a movie" do
      movie = movies(:dumbo)
      movie.valid?.must_equal true
    end

    it "won't create movie without title" do
      movie = movies(:dumbo)
      movie.title = ""

      movie.valid?.must_equal false
      movie.errors.messages.must_include :title
    end

    it "won't create movie without release_date" do
      movie = movies(:dumbo)
      movie.release_date = ""

      movie.valid?.must_equal false
      movie.errors.messages.must_include :release_date
    end

    it "won't create movie without overview" do
      movie = movies(:dumbo)
      movie.overview = ""

      movie.valid?.must_equal false
      movie.errors.messages.must_include :overview
    end

    it "won't create movie without inventory" do
      movie = movies(:dumbo)
      movie.inventory = nil

      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
    end

    it "inventory must be an integer" do
      movie = movies(:dumbo)

      movie.inventory = "five"
      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
    end

    it "inventory must not be lt 0" do
      movie = movies(:dumbo)

      movie.inventory = -1
      movie.valid?.must_equal false
      movie.errors.messages.must_include :inventory
    end

    it "inventory can be 0" do
      movie = movies(:dumbo)

      movie.inventory = 0
      movie.valid?.must_equal true
    end

    it "inventory can be more than 0" do
      movie = movies(:dumbo)

      movie.inventory = 1
      movie.valid?.must_equal true
    end


    it "won't create movie without available_inventory" do
      movie = movies(:dumbo)
      movie.available_inventory = nil

      movie.valid?.must_equal false
      movie.errors.messages.must_include :available_inventory
    end

    it "available_inventory must not be lt 0" do
      movie = movies(:dumbo)

      movie.available_inventory = -1
      movie.valid?.must_equal false
      movie.errors.messages.must_include :available_inventory
    end

    it "available_inventory can be 0" do
      movie = movies(:dumbo)

      movie.available_inventory = 0
      movie.valid?.must_equal true
    end

    it "available_inventory can be more than 0" do
      movie = movies(:dumbo)

      movie.available_inventory = 1
      movie.valid?.must_equal true
    end


  end

end
