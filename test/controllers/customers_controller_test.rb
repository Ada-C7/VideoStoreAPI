require "test_helper"

describe CustomersController do

     describe "index" do

          before do
               get customers_path
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

          it "contains name, date regiesterd, postal code and phone" do
               @json_response.each do | customer |
                    customer.respond_to? customer['name']
                    customer.respond_to? customer['registered_at']
                    customer.respond_to? customer['postal_code']
                    customer.respond_to? customer['phone']

               end
          end
     end
end
