require "test_helper"

describe MoviesController do
  describe "Index" do
    it "The route works" do
      get movies_url
      must_respond_with :success
    end

    it "Returns JSON" do
      get movies_url
      response.header['Content-Type'].must_include 'json'
    end

    it "Returns an Array" do
      get movies_url
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "Returns all the movies" do
      get movies_url

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "Returns movies with all required fields" do
      keys = %w(available_inventory release_date title)
      get movies_url

      body = JSON.parse(response.body)
      # puts body
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "Renders 204 for when no movies in data base" do
      Movie.destroy_all

      get movies_url
      assert_response :no_content
    end
  end

  describe 'Show' do
    it 'can get a movie' do
      get movie_path(movies(:one).title)
      must_respond_with :success
      movies(:one).title.must_equal "Jaws"
      movies(:one).overview.must_equal "Lots of teeth"
      movies(:one).release_date.must_equal "date"
      movies(:one).inventory.must_equal 1
      # movies(:one).available_inventory.must_equal 1
    end

    it 'returns 204 if movies does not exist' do
      get movie_path(Movie.last.title + "random_bug")
      must_respond_with :no_content
    end
  end
end
