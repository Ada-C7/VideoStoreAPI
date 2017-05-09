require "test_helper"

describe Customer do
  describe "associations/relation" do
    it "has many movies" do
      ar = Customer.reflect_on_association(:movies)
      ar.macro.must_equal :has_and_belongs_to_many
    end
  end
end
