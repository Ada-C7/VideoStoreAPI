require "test_helper"

describe Rental do
  let(:rental) { Rental.new }
  let(:sample_customer) {customers(:good_data)}
  let(:sample_movie) {movies(:psycho)}

  it "can be created with an associated movie and customer" do
    rental.movie = Movie.first
    rental.customer = Customer.last
    rental.save.must_equal true

  end

  it "cannot be created without a movie" do
    rental.customer_id = sample_customer.id
    rental.checkout_date = Date.current
    rental.due_date = Date.current
    rental.save.must_equal false
    rental.errors.messages.must_include :movie

  end

  it "also cannot be created without a customer" do
    rental.movie = Movie.first
    rental.customer = nil
    rental.save.must_equal false

  end

  it "should be assigned today's date as default for checkout_date" do
    rental.customer_id = sample_customer.id
    rental.movie_id = sample_movie.id
    rental.save.must_equal true
    rental.checkout_date.must_equal Date.today

  end

  it "should be assigned a default due date of two weeks from today" do
    rental.movie = Movie.first
    rental.customer = Customer.last
    rental.due_date.must_equal Chronic.parse('two weeks from today')
  end

end
