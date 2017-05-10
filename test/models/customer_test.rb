require "test_helper"

describe Customer do
  # let(:customer) { Customer.new }

  describe "relationships" do
    it "can have many rentals" do
      customer = customers(:one)
      customer.rentals.count.must_equal 2
    end

    it "returns an empty array if there are no rentals created under this customer" do
      customer = Customer.create(name: "who", phone: "123-1234")
      arry = []
      customer.rentals.must_equal arry
    end

    it "returns an empty array for movies if there are no rentals created under this customer" do
      customer = Customer.create(name: "who", phone: "123-1234")
      arry = []
      customer.movies.must_equal arry
    end

    it "can have many movies" do
      customer = customers(:one)
      customer.movies.count.must_equal 2
    end

    it "can access movies" do
      customer = customers(:one)
      movie = customer.rentals[0].movie
      customer.movies[0].title.must_equal movie.title
    end
  end

  describe "validations" do
    it "can create a customer with a customer name and phone number" do
       start_count = Customer.all.length
       customer = Customer.create(name: "who", phone: "123-1234")
       Customer.all.length.must_equal start_count + 1
    end

    it "won't create a customer without phone number or customer name" do
       start_count = Customer.all.length
       customer = Customer.create
       Customer.all.length.must_equal start_count
    end

    it "won't create a customer without a customer name" do
       start_count = Customer.all.length
       customer = Customer.create(phone: "123-1234")
       Customer.all.length.must_equal start_count
    end

    it "won't create a customer without a phone number" do
       start_count = Customer.all.length
       customer = Customer.create(name: "who")
       Customer.all.length.must_equal start_count
    end
  end

end
