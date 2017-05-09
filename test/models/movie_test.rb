require "test_helper"

describe Movie do
  let(:movie) { Movie.new }
  let(:psycho) {movies(:psycho)}


  # bad_data1:
  #   overview: "Nothing happens."
  #   release_date: 1960-06-16
  #   inventory: 4
  #
  # bad_data2:
  #   overview: "Even more of nothing happens."
  #   release_date: 1970-04-22
  #
  # bad_data3:
  #   title: "Whatevs."
  #at least one positive and one neg case
  # for each relation
  # for each validation
  describe "validations" do
    it "must have both a title and an inventory count" do
      movie.title = "North by Northwest"
      movie.inventory = 8
      movie.save.must_equal true
    end

    it "must not allow a movie without a title and inventory" do
      movie.overview = "Nothing happens."
      movie.release_date = 1960-06-16
      movie.save.must_equal false
      movie.errors.messages.must_include :title
      movie.errors.messages.must_include :inventory

    end

    it "must have a unique combination of title and release date" do skip

    end

    it "must not allow a movie with a duplicate title/release date pair" do skip

    end

    it "must have an inventory greater than or equal to zero" do skip

    end
  end

  describe "relations" do
    it "may have zero or more rentals" do skip

    end
  end
end
