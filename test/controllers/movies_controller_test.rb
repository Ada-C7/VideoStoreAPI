require "test_helper"

describe MoviesController do

  describe "Movies#Index" do

    FIELDS = %w(title release_date)

    before do
      get movies_path
    end

    it "should get index" do
      must_respond_with :success
    end

    it "returns json" do
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns the correct fields" do
      body = JSON.parse(response.body)
      body.each do | movie |
        movie.keys.sort.must_equal FIELDS
      end
    end

  end

  describe "Movies#Show" do

    it "should get show" do
      get movies_show_url
      value(response).must_be :success?
    end

  end

end
