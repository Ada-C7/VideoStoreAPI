require "test_helper"

describe Movie do

  it "must have all field present" do
    movies(:jaws).valid?.must_equal true
    movies(:no_title).valid?.must_equal false
    movies(:no_overview).valid?.must_equal false
    movies(:no_date).valid?.must_equal false
    movies(:no_inv).valid?.must_equal false
  end

  it "must have an inventory that is not in the negative" do
    movies(:starwars).valid?.must_equal true
    movies(:neg_inv).valid?.must_equal false
  end
end
