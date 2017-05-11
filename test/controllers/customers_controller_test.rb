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
    end
end
