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

     describe "validations" do

          it "creates customer with name" do
               customer = Customer.create(name: "Chewie")
               customer.errors.messages.wont_include :name
          end

          it "creates customer with date registered" do
               customer = Customer.create(registered_at: 1973)
               customer.errors.messages.wont_include :registered_at
          end

          it "creates movie with postal code" do
               customer = Customer.create(postal_code: 37373)
               customer.errors.messages.wont_include :postal_code
          end

          it "creates movie with phone" do
               customer = Customer.create(phone: '373-3737')
               customer.errors.messages.wont_include :phone
          end

          it "requires name, date, postal code and phone to create a customer" do
               customer = Customer.create
               customer.name = "Chewbacca"
               customer.registered_at = 1973
               customer.postal_code = 37373
               customer.phone = '373-3737'
               customer.valid?.must_equal true
          end

          it "allows duplicate names if phone and postal code differ" do
               customer = Customer.create
               customer.name = "Princess Leia"
               customer.registered_at = 1973
               customer.postal_code = 37373
               customer.phone = '373-3737'
               customer.valid?.must_equal true
          end

          it "doesn't allow duplicate names if phone and postal code are the same" do
               customer = Customer.create
               customer.name = "Princess Leia"
               customer.registered_at = 1978
               customer.postal_code = 33333
               customer.phone = '333-3333'
               customer.valid?.must_equal false
          end
     end
end
