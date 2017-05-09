require "test_helper"

describe MoviesController do


  KEYS = %w(title overview release_date inventory available_inventory).sort

  describe "index" do
    it "is a working route" do
      get movies_url
      must_respond_with :success
    end

    it "returns json" do
      get movies_url
      response.header["Content-Type"].must_include 'json'
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

    it "returns movies with the required fields" do
      get movies_url
      body = JSON.parse(response.body)

      body.each do |movie|
        movie.keys.sort.must_equal KEYS
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_url(movies(:one).title)
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_instance_of Hash
      body.keys.sort.must_equal KEYS
    end
  end

end
