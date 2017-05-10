require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "must be valid" do
    skip
    value(movie).must_be :valid?
  end
  it 'available inventory can not be greater than inventory' do
    skip
  end
end
