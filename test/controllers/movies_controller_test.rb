require "test_helper"

describe MoviesController do
  describe "index" do

    it "is a real working route that returns json" do
      get movies_path

      must_respond_with :success
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array of all the customers" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(release_date title)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "gives an approriate error message and status not found if there are no movies" do
      Movie.destroy_all
      get movies_path
      must_respond_with :not_found
      body = JSON.parse(response.body)
      error_hash = { "error" => "We have no movies at this time"}
      body.must_equal error_hash
    end
  end

  describe "show" do
    it "can get a movie that exists" do
      get movie_path('Psycho')
      must_respond_with :success

    end

    it "returns json" do
      get movie_path('psycho')
      response.header['Content-Type'].must_include 'json'
    end


    it "gives an approriate error message and status not found for a movie that does not exist" do

      get movie_path('Bad Title')
      must_respond_with :not_found

      body = JSON.parse(response.body)

      error_hash = { "error" => "Could not find a movie with the title Bad Title"}
      body.must_equal error_hash
    end

  end





end
