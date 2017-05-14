require "test_helper"

describe Movie do

  describe 'movie' do
    it "all movies must be an object" do
      movies = Movie.all
      movies.each do |movie|
        movie.must_be_kind_of Object
      end
    end

    it "all movies must be an object" do
      movies = Movie.all
      movies.each do |movie|
        movie.must_be_kind_of Movie
      end
    end
  end

  describe 'validations' do
    it 'movie with all validations is valid' do
      movies(:one).must_be :valid?
    end

    it 'movie is invalid without title' do
      movie = movies(:one)
      movie[:title] = nil
      movie.save

      movie.wont_be :valid?
    end

    it 'movie is invalid without release_date' do
      movie = movies(:one)
      movie[:release_date] = nil
      movie.save

      movie.wont_be :valid?
    end
  end

  it 'available inventory can not be greater than inventory' do
    skip
  end

  # describe 'available_inventory' do
  #   it 'returns correct available inventory' do
  #     # org_inventory = movies(:one).inventory - 1
  #     # a_i = movies(:one).available_inventory
  #     #
  #     # puts '<<<<'
  #     # puts org_inventory
  #     # puts '<<<<'
  #     # puts '<<<<'
  #     # puts a_i
  #     # puts '<<<<'
  #     #
  #     # org_inventory.must_equal movies(:one).available_inventory
  #   end
end
