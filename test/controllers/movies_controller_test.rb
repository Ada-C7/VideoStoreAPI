require "test_helper"

describe MoviesController do
  describe "index" do
    it "routes successfully" do
      get movies_url
      must_respond_with :success
    end

    it "returns json" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns the appropriate fields" do
      fields = %w(title release_date)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal fields.sort
      end
    end
  end

  describe "show" do
    it "routes successfully with valid id" do
      get movie_path(movies(:star_wars).title)
      must_respond_with :success
    end

    it "returns the appropriate fields" do
      fields = %w(title overview release_date inventory available_inventory)
      get movie_url(movies(:star_wars).title)
      body = JSON.parse(response.body)
      body.keys.sort.must_equal fields.sort
    end

    it "responds appropriately when the movie is not found" do
      get movie_url("This is a fake title okay")
      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
      must_respond_with :not_found
    end
  end
end
