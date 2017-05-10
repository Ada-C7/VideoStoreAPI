require "test_helper"

describe RentalsController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "check_in" do
    it "succeeds for valid title and customer id" do
      #valid means: rental exists [and therefore movie and customer exist]
    end

    it "modifies the db with today's date as checkin date" do

    end

    it "renders bad request for invalid customer id data" do
      #customer id not found
    end

    it "renders a different message if rental does not exist" do
      #rental does not exist (customer does not actually have that movie checked out)
    end

    it "returns status not found if movie not found" do
      #movie title does not return movie
    end
  end
end
