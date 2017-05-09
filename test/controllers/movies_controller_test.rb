require "test_helper"

describe MoviesController do
  MOVIE_INDEX_KEYS = %w(release_date title)
  MOVIE_SHOW_KEYS = %w(inventory overview release_date title)

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
        movie.keys.sort.must_equal MOVIE_INDEX_KEYS
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:two).title)
      must_respond_with :success
    end

    it "returns a Hash in json" do
      get movie_path(movies(:two).title)
      body = JSON.parse(response.body)

      body.must_be_kind_of Hash
      response.header['Content-Type'].must_include 'json'
    end

    it "returns movie with exactly the required fields" do
      get movie_path(movies(:three).title)
      body = JSON.parse(response.body)

      body.keys.sort.must_equal MOVIE_SHOW_KEYS
    end

    it "movie has the right information" do
      get movie_path(movies(:one).title)
      body = JSON.parse(response.body)

      MOVIE_SHOW_KEYS.each do |key|
        body[key].must_equal movies(:one)[key]
      end
    end

    it "responds appropriately when given an invalid title" do
      get movie_path("BadTitle")
      body = JSON.parse(response.body)

      body.must_include "errors"
      body["errors"]["title"].must_equal ["Movie 'BadTitle' not found"]
      must_respond_with :not_found
    end
  end
end
