require "test_helper"

describe Rental do
  let(:rental) { Rental.new }
  let(:sample_customer) {customers(:good_data)}
  let(:sample_movie) {movies(:psycho)}

  it "can be created with an associated movie and customer" do skip

  end

  it "cannot be created without a movie" do
    rental.customer_id = sample_customer.id
    rental.checkout_date = Date.current
    rental.due_date = Date.current
    rental.save.must_equal false
    rental.errors.messages.must_include :movie
  end

  it "also cannot be created without a customer" do

  end

  it "should be assigned today's date as default for checkout_date" do

  end

  it "should be assigned a default due date of two weeks from today" do

  end

  it "cannot be created without a due date or checkout date" do

  end
end
