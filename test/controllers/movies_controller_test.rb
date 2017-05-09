require "test_helper"

describe MoviesController do
  describe 'Index' do

    it 'is a real working api route' do
      get movies_path
      must_respond_with :success
    end

    it 'returns json' do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it 'returns an array' do
      get movies_path
      response.parsed_body.must_be_instance_of Array
    end
  end
end
