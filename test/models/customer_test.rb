require "test_helper"

describe Customer do
  describe 'validations for Customer' do
    it 'requires a name' do
      ada = customers(:one)
      ada.valid?.must_equal true
      ada.errors.messages.wont_include :name

      grace = Customer.new(phone: "(415)-567-8743")
      grace.valid?.must_equal false
      grace.errors.messages.must_include :name
    end


    it 'requires a phone number' do
      ada = customers(:one)
      ada.valid?.must_equal true
      ada.errors.messages.wont_include :phone

      grace = Customer.new(name: "Grace Hopper")
      grace.valid?.must_equal false
      grace.errors.messages.must_include :phone

    end

    it 'requires a unique phone number' do
      jane = Customer.new( name: "Jane Doe", phone: "(555)-555-5555" )
      jane.valid?.must_equal false
      jane.errors.messages.must_include :phone
    end
  end

  describe "custom methods" do
    #need to update when we add rentals
    it "movies_checked_out_count returns the number of rentals belonging to the customer" do
      customer = customers(:one)
      customer.movies_checked_out_count.must_equal 0

    end
  end
end
