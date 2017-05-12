require "test_helper"

describe MoviesController do

  describe "index" do

    it "is a real working route" do
      get movies_url
      must_respond_with :success
    end

    it "returns json" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      get movies_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_url
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = ["release_date", "title"]
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "returns empty array if no movies" do
      Movie.destroy_all
      get movies_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be_empty
    end

  end

  describe "show" do

    it "can get a movie" do
      movie = movies(:best_case)
      get movie_path(movie.title)
      must_respond_with :success
    end

    it "gets the right movie" do
      movie = movies(:best_case)
      get movie_path(movie.title)
      body = JSON.parse(response.body)
      body["title"].must_equal movie.title
    end

    it "returns 204 no content if movie does not exist" do
      get movie_path(Movie.last.id + 1)
      must_respond_with :no_content
    end

  end
end
