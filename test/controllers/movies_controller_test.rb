require "test_helper"

describe MoviesController do

  describe "Movies#Index" do

    FIELDS = %w(release_date title)

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

    FIELDS = %w()

    before do
      get movie_path(movies(:nemo).id)
    end

    it "can get a movie" do
      must_respond_with :success
    end

    it "will return json" do
      response.header['Content-Type'].must_include 'json'
    end

    it "returns a hash" do
      body = JSON.parse(response.body)
      body.must_be_instance_of Hash
    end

    it "displays the correct fields" do
      body = JSON.parse(response.body)
      body.keys.sort.must_equal FIELDS
    end

    it "displays the correct information" do
      body = JSON.parse(response.body)
      FIELDS.each do | field |
        body[field].must_equal movies(:nemo)[name]
      end
    end

    it "responds correctly when the pet is not found" do
      get movie_path(Movie.all.last.id + 1) # could also do Pet.all.last.id + 1
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end

  end
end
