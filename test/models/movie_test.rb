require "test_helper"

describe Movie do
  describe "index" do
    it "is a real working route" do
      get movies_url
      must_respond_with :success
    end
  end
end
