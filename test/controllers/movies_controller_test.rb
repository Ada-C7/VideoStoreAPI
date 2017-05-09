require "test_helper"

describe MoviesController do
  MOVIE_KEYS = %w(available_inventory inventory overview release_date title)

  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns an array" do
      get movies_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_path
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns a json" do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns movies with exactly the required fields" do
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal MOVIE_KEYS
      end
    end

    it "returns an empty array if no movies" do
      Movie.delete_all
      get movies_path
      body = JSON.parse(response.body)
      body.must_equal []
    end
  end

  describe "show" do
    it "gets a single movie" do
      get movie_path(movies(:dumbo).title)
      must_respond_with :success
    end

    it "returns a json object specific to not found" do
      get movie_path("2;i5h23;kj5h23;jk5h23;lk5hj")
      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end

    it "gets the correct movie" do
      get movie_path(movies(:dumbo).title)
      body = JSON.parse(response.body)

      MOVIE_KEYS.each do |key|
        body[key].must_equal movies(:dumbo)[key]
      end
    end

    it "returning the right keys" do
      get movie_path(movies(:dumbo).title)
      must_respond_with :success

      body = JSON.parse(response.body)
      body.keys.sort.must_equal MOVIE_KEYS
    end
  end

end
