require 'test_helper'

describe MoviesController do
  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get movies_url

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_url

      body = JSON.parse(response.body)
      body.length.must_equal movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(age human id name)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    # This bit is up to you!
    it "can get a movie" do
      get movie_path(movies(:two).id)
      must_respond_with :success
    end

    it "returns a 204 for a non-existant movie" do
      get movie_path(120)
      must_respond_with :no_content
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        name: "Jack",
        age: 7,
        human: "Captain Barbossa"
      }
    }

  end
end
