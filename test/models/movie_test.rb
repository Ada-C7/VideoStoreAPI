require "test_helper"

describe Movie do

  it "must have all unique fields" do
    movies(:jaws).valid?.must_equal true
  end
end
