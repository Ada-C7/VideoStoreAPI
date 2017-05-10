require "test_helper"

describe TestsController do
  it "gets zomg" do
    get zomg_url
    must_respond_with :success
  end

end


#we built a test for your bloody test
