require "test_helper"

describe Movie do
  let(:new_movie) { Movie.new(
    title: "Bubble Boy",
    overview: "Super cool movie about a boy in a bubble.",
    release_date: "2001-08-24",
    inventory: 10
  ) }

  REQUIRED_FIELDS = %w(title release_date inventory)

  describe "validations" do
    it "can create a movie" do
      new_movie.must_be :valid?
      new_movie.save.must_equal true
    end

    REQUIRED_FIELDS.each do |field|
      it "#{field} is required" do
        new_movie[field] = nil
        new_movie.valid?.must_equal false
        new_movie.errors.messages.must_include field.to_sym
      end
    end

    it "inventory must be a non-negative integer" do
      new_movie.inventory = "number"
      new_movie.valid?.must_equal false

      new_movie.inventory = -1
      new_movie.valid?.must_equal false

      new_movie.inventory = 4.5
      new_movie.valid?.must_equal false
    end

    it "title must be unique" do
      new_movie.title = movies(:one).title
      new_movie.valid?.must_equal false
    end
  end
end
