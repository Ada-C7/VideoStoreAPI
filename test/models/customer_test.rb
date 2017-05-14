require "test_helper"

describe Customer do
  # let(:customer) { Customer.new }
  #
  # it "must be valid" do
  #   value(customer).must_be :valid?
  # end
  describe "validations" do
    it "must have a name" do
      customer = Customer.new(postal_code: "12345", phone: "(000) 768-6252", registered_at: "some time")
      customer.valid?.must_equal false
      customer.errors.messages.must_include :name
    end

    it "name must be a string,only including letters and spaces" do
      customer1 = Customer.new(name: 212, postal_code: "12345", phone: "(000) 768-6252", registered_at: "some time")
      customer1.valid?.must_equal false
      customer1.errors.messages.must_include :name
      customer2 = Customer.new(name: "Adam the 2nd", postal_code: "12345", phone: "(000) 768-6252", registered_at: "some time")
      customer2.valid?.must_equal false
      customer2.errors.messages.must_include :name
      customer3 = Customer.new(name: "Adam Smith", postal_code: "12345", phone: "(000) 768-6252", registered_at: "some time")
      customer3.valid?.must_equal true
    end

    it "must have a postal_code that is a string with five numbers" do
      customer1 = Customer.new(name: "Anna", phone: "(000) 768-6252", registered_at: "some time")
      customer1.valid?.must_equal false
      customer1.errors.messages.must_include :postal_code
      customer2 = Customer.new(name: "Anna", postal_code: "1234", phone: "(000) 768-6252", registered_at: "some time")
      customer2.valid?.must_equal false
      customer2.errors.messages.must_include :postal_code
      customer3 = Customer.new(name: "Anna", postal_code: "12345", phone: "(000) 768-6252", registered_at: "some time")
      customer3.valid?.must_equal true
    end

    it "must have a phone number and the phone number must be entered in the format (xxx) xxx-xxxx " do
      customer1 = Customer.new(name: "Anna", postal_code: "12345", registered_at: "some time")
      customer1.valid?.must_equal false
      customer1.errors.messages.must_include :phone
      customer2 = Customer.new(name: "Anna", postal_code: "12345", phone: "000-768-6252", registered_at: "some time")
      customer2.valid?.must_equal false
      customer2.errors.messages.must_include :phone
      customer3 = Customer.new(name: "Anna", postal_code: "12345", phone: "(000) 768-6252", registered_at: "some time")
      customer3.valid?.must_equal true
    end

    it "must have a registered_at " do
      customer = Customer.new(name: "Anna", postal_code: "12345", phone: "(000) 768-6252")
      customer.valid?.must_equal false
      customer.errors.messages.must_include :registered_at
    end
  end # END of describe "validations"

  describe "#movies_checked_out_count" do
    it "basic requrements: returns 0, must be an integer" do
      customer = customers(:one)
      customer.movies_checked_out_count.must_equal 0
      customer.movies_checked_out_count.must_be_kind_of Integer
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
