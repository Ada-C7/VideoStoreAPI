require "test_helper"

describe RentalsController do
  describe "Checkout" do
    let(:rental_data) {
  {
    customer_id: customers(:three).id,
    due_date: 2017-05-05
  }
}

    it "Creates a new rental recod" do
      proc {
        post checkout_path(movies(:one).title), params: {customer_id: customers(:three).id, movie_id: movies(:two).id, due_date: '2017-6-10'
        }
      }.must_change "Rental.count", 1
      must_respond_with :success
    end

    # it "Can checout a movie" do
    #   rental = rentals(:one)
    #   rental.checlout
    #   rental.
    # end

    it "Won't checkout a movie if a movie doesn't exit" do
      proc {
        post checkout_path(title: "not_found"), params: rental_data

      }.must_change "Rental.count",0
    end


    it "Gives error message if new rental was not created" do
    end



  end

end
