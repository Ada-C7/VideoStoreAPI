require "test_helper"

describe RentalController do

  let (:rental) { Rental.new(
    due_date: "12/03/12",
    movie_id: 2,
    customer_id: 2,
    )
  }

  describe "rentals#overdue" do

    OVERDUE_FIELDS = %w(title customer_id name postal_code checkout_date due_date)

    before do
      get overdue_path
    end

    it "should get overdue" do
      value(response).must_be :success?
    end

    it "returns the correct fields" do

    end

  end

  describe "rentals#checkout" do


    before do
      post checkout_path(
        rentals[:rental_one].movie_id,
        rentals[:rental_one].customer_id,
        rentals[:rental_one].due_date,
      )
    end

    it "should get checkout" do
      must_respond_with :success
    end

    #
    #     it "should create a new rental instance" do skip
    #       affect Rental model, change by 1
    #     end
    #
    #     it "should render the correct output if checkout was successful" do skip
    #       status: :ok
    #       render_json display customer_id due_date movie_id
    #     end

    # it "Movie can only be checked out if one is available" do
    # end
    #
    #     it "should render the correct output if checkut was unsuccessful" do skip
    #       status: :bad_request
    #       json: errors
    #     end

  end
end


#
#   describe "rentals#checkin" do
#
#     before do skip
#       post checkin_path
#     end
#
#     it "should get checkin" do skip
#       value(response).must_be :success?
#     end
#
#     it "should change the " do skip
#
#     end
#
#   end
#
# end
