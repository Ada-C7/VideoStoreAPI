require "test_helper"

describe MoviesController do
  it "must get the index" do
    get movies_path
    must_respond_with :success
  end

  it "index must return outputted json" do    
  end
end
