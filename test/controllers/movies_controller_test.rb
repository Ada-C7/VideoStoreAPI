require "test_helper"

describe MoviesController do
  it "must get the index" do
    get movies_path
    must_respond_with :success
  end

  it "index must return outputted json" do
    get movies_path
    response.header['Content-Type'].must_include "json"
  end

  it "returns the correct amount of movies" do
    get movies_path
    r = JSON.parse(response.body)
    r.length.must_equal Movie.count
  end

  it "can get one movie" do
    get movie_path(movies(:starwars).title)
    must_respond_with :success
  end

  it "show returns json" do
    get movie_path(movies(:starwars).title)
    response.header['Content-Type'].must_include "json"
  end

  it "returns a not found if the movie is not found" do
    get movie_path("random movie")
    must_respond_with :not_found
  end
end
