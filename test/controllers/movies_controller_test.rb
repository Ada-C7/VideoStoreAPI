require "test_helper"

describe MoviesController do

     describe "index" do

          before do
               get movies_path
               @json_response = JSON.parse(response.body)
          end

          it "responds" do
               must_respond_with :success
          end

          it "serves json" do
               response.header['Content-Type'].must_include Mime[:json]
          end

          it "responds with a string" do
               response.body.must_be_kind_of String
          end

          it "responds with a string containing an array" do
               @json_response.must_be_kind_of Array
               @json_response.length.must_equal Movie.count

          end

          it "contains title and release date intel" do
               @json_response.each do | movie |
                    movie.respond_to? movie['title']
                    movie.respond_to? movie['release_date']
               end
          end
     end

     describe "show" do

          before do
               get movie_path(movies(:three).title)
               @json_response = JSON.parse(response.body)
          end

          it "retrieves movie within database" do
               response.body.must_include movies(:three).title
               must_respond_with :success
          end

          it "doesn't retrieve movie not within database" do
               get movie_path('empirestrikesback')
               response.body.must_include "errors", "empirestrikesback"
               must_respond_with :not_found
          end

          it "contains movie specific intel" do
               response.body.must_be_kind_of String
          end

          it "responds with a string containing an hash" do
               @json_response.must_be_kind_of Hash
               @json_response.length.must_equal 5
          end

          it "contains movie specific intel" do
               intel = %w(title overview release_date inventory available_inventory)
               @json_response.keys.must_equal intel
          end

          it "contains the right intel" do
               @json_response['title'].must_equal movies(:three).title
               @json_response['overview'].must_equal movies(:three).overview
          end

     end
end
