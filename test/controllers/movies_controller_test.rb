require "test_helper"

describe MoviesController do

  KEYS = %W( title overview release_date inventory)
    describe "index" do
      # These tests are a little verbose - yours do not need to be
      # this explicit.
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
        body.length.must_equal Pet.count
      end

      it "returns movies with exactly the required fields" do
        get movies_url
        body = JSON.parse(response.body)
        body.each do |movie|
          movie.keys.sort.must_equal KEYS
        end
        #movie.keys.must_contain "age"
        #we ensure all kv are the same as the response prior to parsing
      end
    end

    describe "show" do
      # This bit is up to you!

      it "must get a movie" do
        #get the id of a movie by referencing the fixtures
        get movie_path(movies(:two).id)
        must_respond_with :success

        body = JSON.parse(response.body)
        body.must_be_instance_of Hash
        body.keys.sort.must_equal KEYS
      end
    end

    it "responds correctly when movie is not found" do
      get movie_path(100099)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end

    it "when we get a movie it has the right information"  do

      get movie_path(movie(:three).id)

      body = JSON.parse(response.body)

      KEYS.each do |key|
        body[key].must_equal movies(:three)[key]
        #body["human"].must_equal pets(:two).human
      end
    end

    describe "create" do
      let(:movie_data) {
        {
          title: "Flashdance",
          release_date: "1983-04-15",
          inventory: "2"
        }
      }

      let(:bad_data) {
        {
          age: 4,
          human: "Johnny No Sandwish"
        }
      }

      it "Can create a new movies" do
        proc {
          post movies_path, params: { movie: movie_data }
        }.must_change 'Movie.count', 1
        must_respond_with :success
      end

  #tutortimes
      it "won't change the database if data is missing" do

        proc {
          post movie_path, params: {movie: bad_data}
        }.must_change 'Movie.count', 0 #also works wont_change "Pet.title"

        must_respond_with :bad_request

        body = JSON.parse(response.body)
        body.must_be_kind_of Hash
        body.must_include "errors"
        body["errors"].must_include "title"
      end

    end

end
