require "test_helper"

describe MoviesController do
  KEYS = %w(available_inventory inventory overview release_date title)

  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns an array" do
      get movies_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_path
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns a json" do
      get movies_path
      repsonse.header['Content-Type'].must_include 'json'
    end

    it "returns movies with exactly the required fields" do
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal KEYS
      end
    end

    it "returns an empty array if no movies" do
      Movie.delete_all
      get movies_path
      body = JSON.parse(response.body)
      body.must_equal []
    end
  end

  describe "show" do
    it "gets a single movie" do

    end

    it "returns a json object specific to not found" do

    end

    it "gets the correct movie" do

    end

    it "retuning the right keys" do

    end
  end
end
