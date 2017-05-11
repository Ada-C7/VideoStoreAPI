require "test_helper"

describe CustomersController do
    describe  "index" do
        it "can show a list of customers" do
            get customers_path
            must_respond_with :success
        end

        it "succeeds with many customers" do
            Customer.count.must_be :>, 0

            get customers_path
            must_respond_with :success
        end

        it "succeeds with no customers" do
            Customer.destroy_all

            get customers_path
            must_respond_with :success
        end

        it "returns json" do
            get customers_url
            response.header['Content-Type'].must_include 'json'
        end

        it "returns an Array" do
            get customers_url

            body = JSON.parse(response.body)
            body.must_be_kind_of Array
        end

        it "returns all of the customers" do
            get customers_url

            body = JSON.parse(response.body)
            body.length.must_equal Customer.count

        end
        it "returns customers with exactly the required fields" do
            keys = %w(id movies_checked_out_count name phone postal_code registered_at )
            get customers_url
            body = JSON.parse(response.body)
            body.each do |customer|
                customer.keys.sort.must_equal keys
            end
        end
    end
end
