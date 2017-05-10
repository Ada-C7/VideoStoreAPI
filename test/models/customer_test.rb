require "test_helper"

describe Customer do
  # let(:customer) { Customer.new }
  #
  # it "must be valid" do
  #   value(customer).must_be :valid?
  # end
  describe "validations" do
    it "must have a name" do
      customer = Customer.new(address: "234 flower street", phone: "(000) 768-6252", registered_at: "some time")
      customer.valid?.must_equal false
      customer.errors.messages.must_include :name

    end

    it "name must be a string, returns false when integers are entered" do
      customer1 = Customer.new(name: 212, address: "234 flower street", phone: "(000) 768-6252", registered_at: "some time")
      customer1.valid?.must_equal false
      customer1.errors.messages.must_include :name
      customer2 = Customer.new(name: "Adam the 2nd", address: "234 flower street", phone: "(000) 768-6252", registered_at: "some time")
      customer2.valid?.must_equal false
      customer2.errors.messages.must_include :name
      customer3 = Customer.new(name: "Adam Smith", address: "234 flower street", phone: "(000) 768-6252", registered_at: "some time")
      customer3.valid?.must_equal true
    end



    it "name must be a string only including letters and spaces" do
      customer = Customer.new(name: 212, address: "234 flower street", phone: "(000) 768-6252", registered_at: "some time")
      customer.valid?.must_equal false
      customer.errors.messages.must_include :name
    end

    it "must have a street address" do
      customer = Customer.new(name: "Anna", phone: "(000) 768-6252", registered_at: "some time")
      customer.valid?.must_equal false
      customer.errors.messages.must_include :address
    end

    it "must have a phone number" do
      customer = Customer.new(name: "Anna", address: "234 flower street", registered_at: "some time")
      customer.valid?.must_equal false
      customer.errors.messages.must_include :phone

    end

    it "must have a registered_at " do
      customer = Customer.new(name: "Anna", address: "234 flower street", phone: "(000) 768-6252")
      customer.valid?.must_equal false
      customer.errors.messages.must_include :registered_at
    end
  end # END of describe "validations"

  describe "#movies_checked_out_count" do
    it "first test: returns 0" do
      customer = customers(:one)
      customer.movies_checked_out_count.must_equal 0
    end
  end

  describe "associations" do

    it "has many rentals" do
      active_record = Customer.reflect_on_association(:rentals)
      active_record.macro.must_equal :has_many
    end


    it "has many customers" do
      active_record = Customer.reflect_on_association(:movies)
      active_record.macro.must_equal :has_many
    end

  end

end
