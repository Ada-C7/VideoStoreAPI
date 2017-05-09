require "test_helper"

describe Movie do

  describe "relations" do

    it "has a list of rentals" do
      psycho = movies(:psycho)
      psycho.must_respond_to :rentals
      psycho.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end

    it "has a list of customers" do
      psycho = movies(:psycho)
      psycho.must_respond_to :customers
      psycho.customers.each do |customer|
        customer.must_be_kind_of Customer
      end
    end

  end

end
