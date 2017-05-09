require "test_helper"

describe MoviesController do
  describe 'Index' do

    # before do
    #   @movies_count = Movie.count
    # end

    it 'is a real working api route' do
      get movies_path
      must_respond_with :success
    end

    it 'returns json' do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an array of hashes' do
      get movies_path
      response.parsed_body.must_be_instance_of Array
      response.parsed_body.each do |movie_hash|
        movie_hash.must_be_instance_of Hash
      end
    end

    it 'returns the correct amount of movies' do
      get movies_path
      response.parsed_body.length.must_equal Movie.count
    end

    it 'returns movies with the expected fields' do
      keys = %w(release_date title)
      get movies_path
      response.parsed_body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    # wait do we need this ...
    it 'returns 500 if there are no movies in db' do
      Movie.destroy_all
      get movies_path
      response.status.must_equal 500
      response.parsed_body.must_include "error"
    end
  end
end
