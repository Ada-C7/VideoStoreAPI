require "test_helper"

describe Movie do

  describe 'validations' do
    before do
      @input = { title: "Harry Potter",
                 overview: "Boy learns he is a wizard",
                 release_date: "11-23-2001",
                 inventory: 10,
                 available_inventory: 10

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
        input = @input.dup
        input.delete(attribute)
        movie = Movie.new(input)
        movie.valid?.must_equal false
        movie.errors.must_include attribute
      end
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
