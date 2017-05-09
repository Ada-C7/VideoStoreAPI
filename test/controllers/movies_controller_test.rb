require "test_helper"

describe MoviesController do
  MOVIE_KEYS = %w(release_date title)

  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array of all the movies" do
      get movies_path
      body = JSON.parse(response.body)

      body.must_be_kind_of Array
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      get movies_path
      body = JSON.parse(response.body)

      body.each do |movie|
        movie.keys.sort.must_equal MOVIE_KEYS
      end
    end
  end
end
