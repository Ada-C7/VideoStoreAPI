require "test_helper"

describe Movie do
  let(:movie) { Movie.new }
  let(:psycho) {movies(:psycho)}


  #at least one positive and one neg case
  # for each relation
  # for each validation
  describe "validations" do
    it "must have both a title and an inventory count" do

    end

    it "must not allow a movie without a title and inventory" do

    end

    it "must have a unique combination of title and release date" do

    end

    it "must not allow a movie with a duplicate title/release date pair" do
      
    end
  end

  describe "relations" do
    it "may have zero or more rentals" do

    end
  end
end
