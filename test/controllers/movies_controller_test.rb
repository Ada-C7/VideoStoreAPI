require "test_helper"

describe MoviesController do
  describe "index" do
    it "is successful renders when there are many movies" do
      Movie.count.must_be :>, 0
      get movies_path
      must_respond_with :success
    end

    it "is successful when there are zero movie" do
      Movie.destroy_all
      get movies_path
      must_respond_with :success
    end

    it "returns JSON" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array of movies" do
      get movies_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_url
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with the right fields" do
      fields = %w(available_inventory inventory overview release_date title)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal fields
      end
    end
  end
  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:lalaland).title)
      must_respond_with :success
    end

    it "will show an error message with no movie found" do
      get movie_path("hello_sofia")
      must_respond_with :not_found
    end

  end
end
