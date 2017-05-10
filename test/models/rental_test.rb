require "test_helper"
require 'date'

describe Rental do

  before do
    @checkout
  end

  let(:movie) { movies(:one) }
  let(:customer) { customers(:good_customer) }

  it "requires all attributes" do
    rental = Rental.new
    rental.movie_id = movie.id
    rental.customer_id = customer.id
    rental.check_out_date = Date.today
    rental.due_date = Date.today + 3
    rental.status = "checked out"
    rental.valid?.must_equal true
    rental.save
    Rental.find_by(customer_id: customer.id).wont_be_nil
  end
end
