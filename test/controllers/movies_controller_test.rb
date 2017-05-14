require 'test_helper'

describe MoviesController do
  describe "index" do
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

    it "returns movies with exactly the required fields" do
      keys = %w(title release_date)
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys.sort
      end
    end
  end

  describe "show" do
    # This bit is up to you!
    it "can get a movie" do
      get movie_path(movies(:tusk).title)
      must_respond_with :success
    end

    it "returns a 404 for a non-existant movie and gives detailed error message" do
      get movie_path(title: "aserabr" )
      must_respond_with :not_found
      movie = JSON.parse(response.body)["errors"]
      movie.must_be_kind_of Hash
      movie.keys.must_include "title"
    end

    it "returns a movie with exactly the required fields" do
      keys = %w(title overview release_date inventory available_inventory)
      get movie_path(title: "Little Mermaid" )
      movie = JSON.parse(response.body)
      movie.keys.sort.must_equal keys.sort
    end
  end

  describe "check-out" do
    it "subtracts the checked-out movie from available inventory" do
      pre = movies(:life).available_inventory
      pre.must_equal movies(:life).inventory
      post checkout_path(title: "Life is Beautiful", customer_id: customers(:one).id)
      must_respond_with :success
      Movie.find_by(title: movies(:life).title).available_inventory.must_equal (pre - 1)
    end

    it "returns returns not found if the movie would be taken below zero" do
      pre = movies(:mermaid).available_inventory
      pre.must_equal 0

      post checkout_path(title: "Little Mermaid", customer_id: customers(:one).id)
      must_respond_with :not_found

      movie = JSON.parse(response.body)["errors"]
      movie.must_be_kind_of Hash
      movie.keys.must_include "unavailable"
    end
  end

  describe "check-in" do

    it "adds a movie to the inventory when it is checked in" do
      pre = movies(:life).available_inventory
      pre.must_equal movies(:life).inventory

      post checkout_path(title: "Life is Beautiful", customer_id: customers(:one).id)
      must_respond_with :success

      post checkin_path(title: "Life is Beautiful", customer_id: customers(:one).id)
      must_respond_with :success

      Movie.find_by(title: movies(:life).title).available_inventory.must_equal pre
    end
  end
end
