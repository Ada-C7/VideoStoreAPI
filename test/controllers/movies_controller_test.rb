require "test_helper"

describe MoviesController do

     it "should get index" do
          get movies_path
          must_respond_with :ok
     end

end
