require "test_helper"

describe MoviesController do


  describe "index" do
    INDEX_KEYS = %w(release_date title)

    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_path
      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movie with exactly the required fields" do
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal INDEX_KEYS
      end
    end
  end


  describe "show" do
    SHOW_KEYS = %w(available_inventory inventory overview release_date title)

    it "can get a movie" do
      get movie_path(movies(:one).title)
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_instance_of Hash
      body.keys.sort.must_equal SHOW_KEYS
    end

    it "responds correctly when movie is not found" do
      get movie_path("Developers")
      body = JSON.parse(response.body)
      body.keys.must_include "errors"
      must_respond_with :not_found
    end

    it "gives the right info for a movie" do
      get movie_path(movies(:two).title)
      body = JSON.parse(response.body)

      movie_model_keys = %w(inventory overview release_date title)
      movie_model_keys.each do |key|
        body[key].must_equal movies(:two)[key]
      end

     movie =  Movie.find_by(title: movies(:two).title)
     body["available_inventory"].must_equal movie.available_inventory

    end

  end
end
