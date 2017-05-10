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
  describe "model methods" do
    it "returns the correct amount of available inventory" do
      psycho = movies(:psycho)
      psycho.must_respond_to :available_inventory
      psycho.available_inventory.must_equal 7
      psycho.inventory.must_equal 8
    end

    it "changes when I check out a new movie" do
      rental = rentals(:three)
      psycho = movies(:psycho)
      psycho.available_inventory.must_equal 7
      rental.checked_out = true
      rental.save
      psycho.reload
      psycho.available_inventory.must_equal 6
    end
  end
end
