require "test_helper"

describe MoviesController do

  describe "index" do

    it "is a real working route" do
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

    it "returns all of the movies" do
      get movies_url
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = ["release_date", "title"]
      get movies_url
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "returns empty array if no movies" do
      Movie.destroy_all
      get movies_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be_empty
    end

  end

  describe "show" do

    it "returns JSON" do
      movie = movies(:best_case)
      get movies_url(movie.title)
      response.header['Content-Type'].must_include 'json'
    end

    it "can get a movie" do
      movie = movies(:best_case)
      get movie_path(movie.title)
      must_respond_with :success
    end

    it "gets the right movie" do
      movie = movies(:best_case)
      get movie_path(movie.title)
      body = JSON.parse(response.body)
      body["title"].must_equal movie.title
    end

    it "returns a movie with exactly the required fields" do
      keys = ["available_inventory", "inventory", "overview", "release_date", "title"]
      movie = movies(:best_case)
      get movie_path(movie.title)
      body = JSON.parse(response.body)
      body.keys.sort.must_equal keys
    end

    it "returns a single JSON object" do
      movie = movies(:best_case)
      get movie_path(movie.title)
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
    end

    it "returns 404 not found if movie does not exist" do
      get movie_path("Bogus title")
      must_respond_with :not_found
    end

  end

  describe "checkout" do

    it "decreases movie available_inventory by 1" do
      customer = customers(:perfect)
      due_date = "2017-06-01"
      movie = movies(:best_case)
      start_inventory = movie.available_inventory

      post checkout_path(movie.title), params:{customer_id: customer.id, due_date: due_date}
      movie.reload

      end_inventory = movie.available_inventory
      start_inventory.must_equal end_inventory + 1
    end

    it "increases customer movies_checked_out_count by 1" do
      customer = customers(:perfect)
      due_date = "2017-06-01"
      movie = movies(:best_case)
      start_count = customer.movies_checked_out_count

      post checkout_path(movie.title), params:{customer_id: customer.id, due_date: due_date}
      customer.reload

      end_count = customer.movies_checked_out_count
      start_count.must_equal end_count - 1
    end

  end
end
