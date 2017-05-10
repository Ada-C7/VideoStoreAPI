require "test_helper"

describe Customer do
  describe "associations/relation" do
    it "has many through movies" do
      ar = Customer.reflect_on_association(:movies)
      ar.macro.must_equal :have_many
    end
  end
end
