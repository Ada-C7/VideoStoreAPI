require "test_helper"

describe MoviesController do
  it "must get the index" do
    get movies_path
    must_respond_with :success
  end

  it "index must return outputted json" do
    get movies_path
    response.header['Content-Type'].must_include "json"    
  end
end
