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
      fake_title = "This is a fake title okay"
      expected_error_message = {"errors"=>{"title"=>["Movie '#{fake_title}' not found"]}}

      get movie_url(fake_title)
      body = JSON.parse(response.body)
      body.must_equal expected_error_message
      must_respond_with :not_found
    end
  end
end
