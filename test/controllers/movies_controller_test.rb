require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a working route" do
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

    it "returns all the movies" do
      get movies_url

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with the required fields" do
      keys = %w(title overview release_date inventory)
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:two).id)
      must_respond_with :success
    end
  end

  describe "create" do
    before do
      movie_data =
      {
        title: "Troy",
        overview: "Prince Paris steals Agamemnon's wife bloodbath ensues",
        release_date: "2012",
        inventory: 30
      }


    it"sends status ok after a successful create" do
      test_movie = Movie.new(movie_data)
      post movies_url, params: { movie: test_movie}
    end

    it"sends status :bad_request after a failed call" do

    end

    it "it successfully creates a movie in the database" do

    end

    it "returns movie details upon creation" do

    end
  end
end
