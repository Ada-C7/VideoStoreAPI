require "test_helper"

describe MoviesController do

  describe "Movies#Index" do

    INDEX_FIELDS = %w(release_date title)

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
        movie.keys.sort.must_equal INDEX_FIELDS
      end
    end

  end

  describe "Movies#Show" do

    SHOW_FIELDS = %w(inventory overview release_date title)

    before do
      get movie_path(movies(:nemo).title)
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
      body.keys.sort.must_equal SHOW_FIELDS
    end

    SHOW_FIELDS.each do | field |
      it "displays the correct #{field}" do
        body = JSON.parse(response.body)
        body[field].must_equal movies(:nemo)[field]
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
