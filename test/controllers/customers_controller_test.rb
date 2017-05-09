require "test_helper"

describe CustomersController do

  describe "index" do

    it "is a real working route" do
      get pets_url
      must_respond_with :success
    end
  end 
end
