require "test_helper"

describe Movie do
  let (:movie) { Movie.new(
    title: "Finding Nemo",
    overview: "Just keep swimming",
    release_date: "2010",
    inventory: "25"
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
end
