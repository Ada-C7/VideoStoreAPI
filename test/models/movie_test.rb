require "test_helper"

describe Movie do

  describe 'validations' do
    before do
      @input = { title: "Harry Potter",
                 overview: "Boy learns he is a wizard",
                 release_date: "11-23-2001",
                 inventory: 10
               }
    end

    # is this more dry?
    def create_movie(info)
      return Movie.new(info)
    end

    it 'good data passes validations' do
      movie = create_movie(@input)
      movie.valid?.must_equal true
    end

    it 'does not allow duplicate titles' do
      Movie.create(@input)
      repeat = Movie.new(@input)
      repeat.valid?.must_equal false
      repeat.errors.must_include :title
    end

    it 'wont create instance if any attrivbute is missing' do
      @input.keys.each do |attribute|
        @input.delete(attribute)
        movie = Movie.new(@input)
        movie.valid?.must_equal false
        movie.errors.must_include key
      end
    end

    it 'has to include an overview' do
      @input.delete(:overview)
      movie_no_overview = Movie.new(@input)
      movie_no_overview.valid?.must_equal false
      movie_no_overview.errors.must_include :overview
    end

    it 'has to include a release data' do
      @input.delete(:release_date)
      movie_no_date = Movie.new(@input)
      movie_no_date.valid?.must_equal false
      movie_no_date.errors.must_include :release_date
    end

    it 'has to include inventory integer' do
      @input.delete(:inventory)
      movie_no_inv = Movie.new(@input)
      movie_no_inv.valid?.must_equal false
      movie_no_inv.errors.must_include :inventory
    end

    it "can't include a negative inventory" do
      @input[:inventory] = -3
      movie = create_movie(@input)
      movie.valid?.must_equal false
      movie.errors.must_include :inventory
   end

   it 'inventory has to be a integer' do
     @input[:inventory] = "one"
     movie = Movie.new(@input)
     movie.valid?.must_equal false
     movie.errors.must_include :inventory
   end
 end
end
