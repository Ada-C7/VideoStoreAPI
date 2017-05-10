require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  it "must be created with a title" do # validaiton for :title
  end

  it "cannot be created without a title" do
  end

end
