require "test_helper"

describe Movie do

     describe "purpose" do

          before do
               @movie = Movie.create
          end

          it "creates a movie" do
               @movie.must_be_kind_of Movie
          end
     end
end
