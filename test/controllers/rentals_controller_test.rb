require "test_helper"

describe RentalsController do
  describe "check_out" do
    it "routes successfully" do
      post check_out_url(movies(:star_wars).title)
      must_respond_with :success
    end

    it "text" do

    end
  end
end
