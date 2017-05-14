require 'test_helper'

describe Customer do

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
        customers(:one).must_be :valid?
      end

      it "customer is invalid without a name" do
        customer = customers(:one)
        customer[:name] = nil
        customer.save

        customer.wont_be :valid?
      end

      it "customer is invalid without registration date" do
        customer = customers(:one)
        customer[:registered_at] = nil
        customer.save

        customer.wont_be :valid?
      end

      it "customer is invalid without postal code" do
        customer = customers(:one)
        customer[:postal_code] = nil
        customer.save

        customer.wont_be :valid?
      end

      it "customer is invalid without phone" do
        customer = customers(:one)
        customer[:phone] = nil
        customer.save

        customer.wont_be :valid?
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
  end
end
