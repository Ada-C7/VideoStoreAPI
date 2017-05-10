require "test_helper"

describe MoviesController do
  ALL_MOVIES = %w(release_date title)
  ONE_MOVIE = %w(id inventory overview release_date title)

  describe "index" do
    it "is a real working route" do
      get movies_url
      must_respond_with :success
    end

    it "returns json" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
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
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal ALL_MOVIES
      end
    end

    it "returns an understanable error message if movies were not found" do
      movies = Movie.destroy_all
      get movies_url
      body = JSON.parse(response.body)
      body.must_equal "no_movies" => "Movies were not found"
      Movie.count.must_equal 0
      must_respond_with :not_found
    end
  end

  describe "show" do
    it "must get a movie" do
      get movie_path(movies(:one).title)
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_be_instance_of Hash
      body.keys.sort.must_equal ONE_MOVIE
    end

    it "Responds correctly when the movie is not found" do
      get movie_path("wrong")

      body = JSON.parse(response.body)
      body["errors"].must_equal "title" => ["Movie 'wrong' not found"]

      must_respond_with :not_found
    end

    it "When we get a movie it has the right information" do
      get movie_path(movies(:one).title)
      body = JSON.parse(response.body)

      ONE_MOVIE.each do |key|
        body[key].must_equal movies(:one)[key]
      end
    end

    it "returns an understandable error message if customers were not found" do
      get movie_path("wrong")
      body = JSON.parse(response.body)
      body.must_equal "errors" => { "title" => ["Movie 'wrong' not found"] }
      must_respond_with :not_found
    end
  end
end
