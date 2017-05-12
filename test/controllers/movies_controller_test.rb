require "test_helper"

describe MoviesController do
  describe "index" do
    it "responds successfully" do
      get movies_url
      must_respond_with :success
    end

    it "responds successfully when there are no movies" do
      Movie.destroy_all
      get movies_url
      must_respond_with :success
    end

    it "returns json" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns all of the movies" do
      get movies_url
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with only the required fields" do
      required_fields = %w(release_date title)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal required_fields
      end
    end
  end

  describe "show" do
    it "responds successfully for an existing movie title" do
      get movie_url(movies(:jaws).title)
      must_respond_with :success
    end

    it "responds with not_found for a non-existent movie title" do
      get movie_url("fake movie title")
      must_respond_with :not_found
    end

    it "returns an informative error message if a movie does not exist" do
      get movie_url("fake movie title")
      body = JSON.parse(response.body)
      body.keys.must_equal ["errors"]
      body.values.first.keys.must_include "title"
    end

    it "returns a movie with only the required fields" do
      required_fields = %w(available_inventory inventory overview release_date title)
      get movie_url(movies(:jaws).title)
      body = JSON.parse(response.body)
      body.keys.sort.must_equal required_fields
    end
  end
end
