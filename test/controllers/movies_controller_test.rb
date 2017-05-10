require "test_helper"

describe MoviesController do

  MOVIE_KEYS = %w(release_date title) #if we loop through this, we can see whether the keys and values work/exist

  describe 'index' do
    it "is a real wokring route" do
      get movies_url
      must_respond_with :success
    end

    it "returns json" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      get movies_url

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all fo the Movies" do
      get movies_url

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with the required fields" do
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal MOVIE_KEYS
      end
    end
  end

  # describe 'show' do
  #   it "can get a movie" do
  #     get movie_path(Movie.all.last.id)
  #     must_respond_with :success
  #   end
  #
  #   it "returns JSON when movie not found" do
  #     get movie_path(Movie.all.last.id+1)
  #     must_respond_with :not_found
  #
  #     body = JSON.parse(response.body)
  #     body.must_equal "not found" => true
  #   end
  #
  #   it "returns the right movie when id" do
  #     get movie_path(Movie.all.first.id)
  #
  #     body = JSON.parse(response.body)
  #
  #     MOVIE_KEYS.each do |key|
  #       body[key].must_equal Movie.all.first[key]
  #     end
  #   end
  #
  # end

end
