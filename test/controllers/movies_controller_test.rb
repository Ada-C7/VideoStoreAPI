require "test_helper"

describe MoviesController do

  MOVIE_KEYS = %w(id inventory overview release_date title)

  describe "index" do
    it "is a real working route" do
      get movies_url
      must_respond_with :success
    end

    it "returns an array of json objects" do
      get movies_url
      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_url
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns required fields" do
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal MOVIE_KEYS
      end
    end
  end

  describe "show" do
    it "must get a movie" do
      get movie_url(movies(:one).title)
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_instance_of Hash
      body.keys.sort.must_equal MOVIE_KEYS
    end

    it "responds correctly when movie not found" do
      get movie_url(Movie.last.id + 1)
      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end

    it "when gets a movie has the right info" do
      get movie_path(movies(:one).title)
      body = JSON.parse(response.body)

      MOVIE_KEYS.each do |key|
        body[key].must_equal movies(:one)[key]
      end
    end
  end
end
