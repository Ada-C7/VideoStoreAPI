require "test_helper"

describe Rental do
  let(:rental) { Rental.new }

  it "requires a movie, customer and due date to create" do
    rental.valid?.must_equal false
  end

  it "can be created with valid customer, movie and due date" do
    rental.customer = customers(:one)
    rental.movie = movies(:one)
    rental.due_date = "1/1/18"

    rental.save.must_equal true
  end

end
