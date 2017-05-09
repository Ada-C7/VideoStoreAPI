require "test_helper"

describe Movie do
  let (:movie) { Movie.new(
    title: "Nemo",
    overview: "Just keep swimming",
    release_date: "2010",
    inventory: 25
    )
  }

  it "Can create a valid movie" do
    movie.must_be :valid?
  end

  REQUIRED_FIELDS = %w(title overview release_date inventory)

  REQUIRED_FIELDS.each do | field |
    it "Movie must have a #{field}" do
      movie[field] = nil
      movie.valid?.must_equal false
      movie.errors.messages.must_include field.to_sym
    end
  end

  it "Must have a unique title" do
    original_movie = Movie.new(
      title: "Lion King",
      overview: "Lifechanging.",
      release_date: "1993",
      inventory: "12"
    )
    original_movie.valid?.must_equal true

    duplicate_movie = Movie.new(
      title: "Lion King",
      overview: "Lifechanging.",
      release_date: "1993",
      inventory: "12"
    )
    duplicate_movie.valid?.must_equal false
    duplicate_movie.errors.messages.must_include :title
  end

  it "Inventory must be a number" do
    movie.inventory = "zero"
    movie.valid?.must_equal false
    movie.errors.messages.must_include :inventory
  end
end
