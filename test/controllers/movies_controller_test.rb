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

    it "returns and array" do
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
      keys = %w(release_date title)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "it repsonds if no movies exist" do
      Movie.destroy_all
      get movies_path
      body = JSON.parse(response.body)
      body["message"].must_be_kind_of String
      must_respond_with :success
    end

  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:up).title)
      must_respond_with :success
    end

    it "can get a specific movie" do
      m = Movie.first
      get movie_path(m.title)
      body = JSON.parse(response.body)
      body["title"].must_equal m.title
    end


    it "can load a page for a specific movie with spaces in title" do
      get movie_path("First Blood")
      must_respond_with :success
    end

    it "can load a page for a specific movie with special characters in title" do
      get movie_path("Romy and Michele's High School Reunion")
      must_respond_with :success
    end

    it "returns 404 not_found if movie does not exist" do
      ng_title = "dkjfsdkj7765%$"
      get movie_path(ng_title)
      must_respond_with :not_found
    end
  end
end
