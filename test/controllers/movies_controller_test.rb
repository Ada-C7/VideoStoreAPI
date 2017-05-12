require "test_helper"

describe MoviesController do

  MOVIE_INDEX_KEYS = %w(release_date title) #if we loop through this, we can see whether the keys and values work/exist
  MOVIE_SHOW_KEYS = %w(available_inventory inventory overview release_date title)

  describe 'index' do
    before do
      get movies_url
    end

    it "is a real working route" do
      must_respond_with :success
    end

    it "returns json" do
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with the required fields" do
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

    it "should return a movie with the right information" do
      body = JSON.parse(response.body)

      MOVIE_SHOW_KEYS.each do |key|
        next if key == "available_inventory"
        body[key].must_equal arabia[key]
      end
    end

    it "should return status not found if the movie is not found" do
      get movie_path("xqrt99")
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end
  end

  describe "overdue" do
    let(:arabia) { movies(:arabia) }

    it "should list customers given a movie with overdue inventory" do
      get overdue(arabia.title)
      must_respond_with :success

    end

    it "should return no movies given a title with no overdue inventory" do skip
    end

    it "should return an error when an invalid movie is given" do skip
    end

  end

end
