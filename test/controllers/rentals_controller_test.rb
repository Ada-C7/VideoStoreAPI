require "test_helper"

describe RentalsController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "check_in" do
    before do
      sample_rental = Rental.create({ movie: Movie.first, customer: Customer.first })

      post checkin_path(Movie.first.title), params: { customer_id: Customer.first.id }
    end

    it "succeeds for valid title and customer id" do 
      #valid means: rental exists [and therefore movie and customer exist]

      must_respond_with :success
    end

    it "modifies the db with today's date as checkin date" do skip
      sample_rental.checkin_date.must_equal Date.today
    end

    it "renders bad request for invalid customer id data" do skip
      #customer id not found
    end

    it "renders a different message if rental does not exist" do skip
      #rental does not exist (customer does not actually have that movie checked out)
    end

    it "returns status not found if movie not found" do skip
      #movie title does not return movie
    end
  end
end
