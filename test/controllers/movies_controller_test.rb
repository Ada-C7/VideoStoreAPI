require "test_helper"

describe MoviesController do

     describe "index" do

          it "responds with movies" do
               get movies_path
               must_respond_with :success
          end

     end

end
