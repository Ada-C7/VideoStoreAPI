require 'test_helper'

describe MoviesController do
  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_path
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(title release_date)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys.sort
      end
    end
  end

  describe "show" do
    # This bit is up to you!
    it "can get a movie" do
      get movie_path(movies(:tusk).id)
      must_respond_with :success
    end

    it "returns a 404 for a non-existant movie" do
      get movie_path((Movie.count + 1))
      must_respond_with :no_content
    end

    it "returns a movie with exactly the required fields" do
      keys = %w(title overview release_date inventory)
      get movie_path(title: "Little Mermaid" )
      movie = JSON.parse(response.body)
      movie.keys.sort.must_equal keys.sort
    end
  end
end
