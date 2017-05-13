require "test_helper"

describe Movie do

  describe "validations"  do


    it "requires a title" do
      titanic = movies(:one)
      titanic.valid?.must_equal true
      titanic.errors.messages.wont_include :title

      movie2 = Movie.new( overview: "godd stuff", release_date: "2012-12-12", inventory: 2)
      movie2.valid?.must_equal false
      movie2.errors.messages.must_include :title

    end

    it "requires an overview" do
      titanic = movies(:one)
      titanic.valid?.must_equal true
      titanic.errors.messages.wont_include :overview

      movie2 = Movie.new( title: "godd stuff", release_date: "2012-12-12", inventory: 2)
      movie2.valid?.must_equal false
      movie2.errors.messages.must_include :overview


    end

    it "requires a release date" do
      titanic = movies(:one)
      titanic.valid?.must_equal true
      titanic.errors.messages.wont_include :release_date

      movie2 = Movie.new( title: "godd stuff", overview: "funny", inventory: 2)
      movie2.valid?.must_equal false
      movie2.errors.messages.must_include :release_date

    end

    it "requires YYYY-MM-DD format for release_date" do
      titanic = movies(:one)
      titanic.valid?.must_equal true
      titanic.errors.messages.wont_include :release_date

      movie2 = Movie.new( title: "good stuff", overview: "funny", release_date: "2017", inventory: 2)
      movie2.valid?.must_equal false
      movie2.errors.messages.must_include :release_date
    end

    it "requires an inventory" do
      guardians = movies(:two)
      guardians.valid?.must_equal true
      guardians.errors.messages.wont_include :inventory

      movie2 = Movie.new( title: "good stuff", overview: "funny", release_date: "2017")
      movie2.valid?.must_equal false
      movie2.errors.messages.must_include :inventory
    end

    it "inventory must be an integer greater than 0" do
      guardians = movies(:two)
      guardians.valid?.must_equal true
      guardians.errors.messages.wont_include :inventory

      movie2 = Movie.new( title: "good stuff", overview: "funny", release_date: "2017", inventory: 0)
      movie2.valid?.must_equal false
      movie2.errors.messages.must_include :inventory

      movie2 = Movie.new( title: "good stuff", overview: "funny", release_date: "2017", inventory: 1.5)
      movie2.valid?.must_equal false
      movie2.errors.messages.must_include :inventory

      movie2 = Movie.new( title: "good stuff", overview: "funny", release_date: "2017", inventory: -2)
      movie2.valid?.must_equal false
      movie2.errors.messages.must_include :inventory
    end
  end

  describe "custom methods" do
    #need to update when we add rentals
    it "available_inventory returns an Integer " do
      # has two rentals
      movie = movies(:one)
      movie.available_inventory.must_equal 18

      #has one rental
      guardians = movies(:two)
      guardians.available_inventory.must_equal 0

      #has no inventory and no rentals
      psycho = movies(:three)
      psycho.available_inventory.must_equal 0

      #has inventory and no rentals
      toy_story = movies(:four)
      toy_story.available_inventory.must_equal 6
    end

  end

end
