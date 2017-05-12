require "test_helper"

describe Customer do
  describe "validations" do
    it "Customer is invalid without a name" do
      customer = Customer.new
      result = customer.valid?
      result.must_equal false

      customer.errors.messages.must_include :name
    end

    it "Creates Customer with name" do
      customer = Customer.create(name: "Sofia")
      customer.errors.messages.wont_include :name
    end

    it "Customer is invalid without an empty name field" do
      customer = Customer.new(name: "")
      result = customer.valid?
      result.must_equal false

      customer.errors.messages.must_include :name
    end

    it "Customer is invalid without a phone" do
      customer = Customer.new
      result = customer.valid?
      result.must_equal false

      customer.errors.messages.must_include :phone
    end

    it "Creates Customer with phone" do
      customer = Customer.create(phone: "Sofia")
      customer.errors.messages.wont_include :phone
    end

    it "Customer is invalid without an empty phone field" do
      customer = Customer.new(phone: "")
      result = customer.valid?
      result.must_equal false

      customer.errors.messages.must_include :phone
    end
  end

  describe "relationships" do
    it "has a movie" do
      dan = customers(:dan)
      dan.must_respond_to :movies
      dan.movies.each do |movie|
        movie.must_be_kind_of Movie
      end
    end

    it "should have many movies" do
      dan = customers(:dan)
      dan.movies.count.must_equal 2
    end
  end


end
