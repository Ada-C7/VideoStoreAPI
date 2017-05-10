# As with all Rails projects, model testing is a requirement. You should have at least one positive and one negative test case for each relation, validation, and custom function you add to your models.
#
# Use good TDD practices, and test before you code. Remember: red-green-refactor.

require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  it "must be valid" do
    value(customer).must_be :valid?
  end



end
