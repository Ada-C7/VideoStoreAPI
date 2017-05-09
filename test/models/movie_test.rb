require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  describe 'Movies#all' do
    it "must return a collection of Movies" do
    end

    it "cannot be created without a title" do
    end
  end

  describe 'Movies#create' do
    it "must be created with a title" do # validaiton for :title
    end

    it "cannot be created without a title" do
    end

    it "adds a movie to our active record" do
    end
  end

  describe 'Movies#find' do
    it "can find a Movie with a valid title" do
    end

    it "cannot find a Movie with a bogus title" do
    end
  end
end

# set up fixtures
