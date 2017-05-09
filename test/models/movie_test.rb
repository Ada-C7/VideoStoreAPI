require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "creates a movie" do
    value(movie).must_be :valid?
  end

  it "won't create movie without title" do

  end

  it "won't create movie without release_date" do

  end

  it "won't create movie without overview" do

  end

  it "won't create movie without inventory" do

  end

  it "won't create movie without available_inventory" do

  end
end
