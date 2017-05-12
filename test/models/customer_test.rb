require 'test_helper'

describe Customer do
  let(:customer) { Customer.new }

  describe 'customer' do

    it 'all customers must be an object' do
      customers = Customer.all
      customers.each do |customer|
        customer.must_be_kind_of Object
      end
    end

    it "all customers in database are correct object" do
      customers = Customer.all
      customers.each do |customer|
        customer.must_be_kind_of Customer
      end
    end

    describe 'validations' do
      it "customer with correct validations is valid" do
        customer(:one).must_be :valid?
      end
    end

    describe 'relations' do
      it 'a customer can have many movies' do
        # skip # Not passing, yaml files need to be fixed.
        customer = customers(:one)
        customer.must_respond_to :movies
        assert_operator 0, :<, customers(:one).movies.size
        customer.movies.each do |movie|
          movie.must_be_kind_of Movie
        end
      end
    end
    # assert_equal 2, users(:user1).reviews.size
    # it "has a list of votes" do
    #   dan = users(:dan)
    #   dan.must_respond_to :votes
    #   dan.votes.each do |vote|
    #     vote.must_be_kind_of Vote
    #   end


    # Unnecessary
    # it 'customer can not be created without required attributes' do
    #   proc { Customer.new }.must_raise ArgumentError
    # end
  end
end
