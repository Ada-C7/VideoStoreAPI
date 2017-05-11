require "test_helper"

describe MoviesController do
  let(:movie) { movies(:strange) }

  INDEX_FIELDS = %w(release_date title)
  SHOW_FIELDS = %w(available_inventory id inventory overview release_date title)

  it "gets index" do
    get movies_url
    must_respond_with :success
  end

  it "index returns JSON" do
    get movies_url
    response.header['Content-Type'].must_include 'json'
  end

  it "returns an array of all movies with correct fields" do
    get movies_url

    body = JSON.parse(response.body)
    body.must_be_kind_of Array
    body.length.must_equal Movie.count
    body.each do |movie|
      movie.keys.sort.must_equal INDEX_FIELDS
    end
  end

  it "gets show" do
    get movie_path(movie.title)
    must_respond_with :success
  end

  it "show returns JSON" do
    get movie_path(movie.title)
    response.header['Content-Type'].must_include 'json'
  end

  it "returns a hash with correct fields" do
    get movie_path(movie.title)

    body = JSON.parse(response.body)
    body.must_be_kind_of Hash
    body.keys.sort.must_equal SHOW_FIELDS
  end

  it "responds correctly if movie not found" do
    skip
    get movie_path(1)
    must_respond_with :not_found

    body = JSON.parse(response.body)
    body.must_equal "errors" => messages.errors
  end

  SHOW_FIELDS.each do | field |
    it "displays the correct #{field}" do
      skip
      body = JSON.parse(response.body)
      body[field].must_equal movie[field]
    end
  end

  # A basic test with no parameters, if applicable
  # Positive and negative tests for any URI parameters (user ID, movie title)
  # Testing around any data in the request body
end
