require "test_helper"

describe Movie do
  let(:movie) { Movie.new }
  let(:psycho) { movies(:psycho) }
  let(:sample_rental) { rentals(:one) }
  let(:sample_customer) { customers(:one) }

  #at least one positive and one neg case
  # for each relation
  # for each validation
  describe "validations" do
    it "must have a title, release date, and inventory count" do
      movie.title = "North by Northwest"
      movie.inventory = 8
      movie.release_date = "1959-07-17"
      movie.save.must_equal true
    end

    it "must not allow a movie without a title, release date and inventory" do
      movie.overview = "Nothing happens."
      movie.save.must_equal false
      movie.errors.messages.must_include :title
      movie.errors.messages.must_include :inventory
      movie.errors.messages.must_include :release_date
    end

    it "must not allow just a title but no inventory or release date" do
      movie.title = "Whatevs"
      movie.save.must_equal false
      movie.errors.messages.must_include :inventory
      movie.errors.messages.must_include :release_date
    end

    it "must permit a unique combination of title and release date" do
      movie.title = psycho.title
      movie.overview = "The animated children's version of the Hitchcock classic"
      movie.release_date = "2015-09-01"
      movie.inventory = 3
      movie.save.must_equal true
    end

    it "must not allow a movie with a duplicate title/release date pair" do
      movie.title = psycho.title
      movie.release_date = psycho.release_date
      movie.inventory = 1
      movie.save.must_equal false
      movie.errors.messages.must_include :title
    end

    it "must have an inventory that is an integer" do
      movie.title = "North by Northwest"
      movie.inventory = "cheezits"
      movie.release_date = "1959-07-17"
      movie.save.must_equal false
      movie.errors.messages.must_include :inventory
    end

    it "must have an inventory greater than or equal to zero" do
      movie.title = "North by Northwest"
      movie.inventory = -7
      movie.release_date = "1959-07-17"
      movie.save.must_equal false
      movie.errors.messages.must_include :inventory
    end
  end

  describe "relations" do
    it "may have zero or more rentals" do
      psycho.rentals.must_include sample_rental
    end

  end
end
