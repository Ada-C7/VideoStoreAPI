require "test_helper"

describe CustomerMovie do
  let(:customer_movie) { CustomerMovie.new }

  it "must be valid" do
    skip
    value(customer_movie).must_be :valid?
  end
end
