require "test_helper"

describe Customer do

  it "must have all fields present" do
    customers(:sam).valid?.must_equal true
    customers(:no_name).valid?.must_equal false
    customers(:no_reg).valid?.must_equal false
    customers(:no_add).valid?.must_equal false
    customers(:no_city).valid?.must_equal false
    customers(:no_state).valid?.must_equal false
    customers(:no_code).valid?.must_equal false
    customers(:no_phone).valid?.must_equal false
    customers(:no_credit).valid?.must_equal false
  end

end
