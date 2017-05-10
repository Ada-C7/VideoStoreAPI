require "test_helper"

describe RentalController do
  it "should get overdue" do
    get rental_overdue_url
    value(response).must_be :success?
  end

  it "should get check_out" do
    get rental_check_out_url
    value(response).must_be :success?
  end

  it "should get check_in" do
    get rental_check_in_url
    value(response).must_be :success?
  end

end
