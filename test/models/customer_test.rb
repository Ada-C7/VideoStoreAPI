require "test_helper"

describe Customer do

  it "must have all fields present" do
    customers(:sam).valid?.must_equal true
  end
end
