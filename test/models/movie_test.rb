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
  end
  
end
