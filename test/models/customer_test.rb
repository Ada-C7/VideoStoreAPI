require "test_helper"

describe Customer do

     describe "purpose" do

          before do
               @customer = Customer.create
          end

          it "creates a customer" do
               @customer.must_be_kind_of Customer
          end
     end
end
