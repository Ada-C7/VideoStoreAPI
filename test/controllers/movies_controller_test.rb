require "test_helper"

describe MoviesController do

  MOVIE_INDEX_KEYS = %w(release_date title) #if we loop through this, we can see whether the keys and values work/exist
  MOVIE_SHOW_KEYS = %w(available_inventory inventory overview release_date title)

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
        movie.keys.sort.must_equal MOVIE_INDEX_KEYS
      end
    end
  end

  describe "show" do
    let(:arabia) { movies(:arabia) }

    before do
      get movie_path(arabia.title)
    end

    it "should find a movie given a title" do
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_instance_of Hash
      body.keys.sort.must_equal MOVIE_SHOW_KEYS
    end

    it "should return a movie with the right information" do skip

    end

    it "should return not found if the movie is not found" do skip

    end
  end

end
