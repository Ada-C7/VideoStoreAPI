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

     describe "validations" do

          it "creates movie with title" do
               movie = Movie.create(title: "Empire Strikes Back")
               movie.errors.messages.wont_include :title
          end

          it "creates movie with overview" do
               movie = Movie.create(overview: "An epic love story between father and son.")
               movie.errors.messages.wont_include :overview
          end

          it "creates movie with release date" do
               movie = Movie.create(release_date: 1973)
               movie.errors.messages.wont_include :release_date
          end

          it "creates movie with inventory" do
               movie = Movie.create(inventory: 0)
               movie.errors.messages.wont_include :inventory
          end

          it "requires title, overview, date and inventory to create a movie" do
               movie = Movie.create
               movie.title = "Empire Strikes Back"
               movie.overview = "An epic love story between father and son."
               movie.release_date = 1973
               movie.inventory = 0
               movie.valid?.must_equal true
          end

          it "doesn't allow duplicate titles" do
               movie = Movie.create
               movie.title = "Jaws"
               movie.overview = "An epic love story between father and son."
               movie.release_date = 1973
               movie.inventory = 0
               movie.valid?.must_equal false
               movie.errors.messages.must_include :title
          end

          it "doesn't allow strings for inventory" do
               movie = Movie.create
               movie.title = "Empire Strikes Back"
               movie.overview = "An epic love story between father and son."
               movie.release_date = 1973
               movie.inventory = 'string'
               movie.valid?.must_equal false
               movie.errors.messages.must_include :inventory
          end

          it "doesn't allow partial movies" do
               movie = Movie.create
               movie.title = "Empire Strikes Back"
               movie.overview = "An epic love story between father and son."
               movie.release_date = 1973
               movie.inventory = 1.6
               movie.valid?.must_equal false
               movie.errors.messages.must_include :inventory
          end
     end
end
