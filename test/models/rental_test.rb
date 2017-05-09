require "test_helper"

describe Rental do
  let(:rental) { Rental.new }

  it "can be created with an associated movie and customer" do
    rental.movie = Movie.first
    rental.customer = Customer.last
    rental.save.must_equal true

  end

  it "cannot be created without a movie" do
  end

  it "also cannot be created without a customer" do
    rental.movie = Movie.first
    rental.customer = nil
    rental.save.must_equal false

  end

  it "should be assigned today's date as default for checkout_date" do
  end

  it "should be assigned a default due date of two weeks from today" do
    rental.movie = Movie.first
    rental.customer = Customer.last
    rental.due_date.must_be Chronic.parse('two weeks from today')
  end

  it "cannot be created without a due date or checkout date" do
  end
end
