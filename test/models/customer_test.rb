require "test_helper"

describe Customer do
    let(:customer) { customers(:alison, :brenna).sample }

    it "must have a name" do
        customer.name.must_equal customer.name
        customer.valid?.must_equal true
    end

    it "is invalid without a name" do
        customer = Customer.create(registered_at: "2017-05-09", phone: 111-111-1111)
        customer.valid?.must_equal false
        customer.errors.messages.must_include :name
    end

    it "must have a phone number" do
        customer.phone.must_equal customer.phone
        customer.valid?.must_equal true
    end

    it "is invalid without a phone number" do
        customer = Customer.create(name: "Ben Smith", registered_at: "2017-05-09")
        customer.valid?.must_equal false
        customer.errors.messages.must_include :phone
    end

    it "must have a registered_at date" do
        customer.registered_at.must_equal customer.registered_at
        customer.valid?.must_equal true
    end

    it "is invalid without a reqistered_at date" do
        customer = Customer.create(name: "Ben Smith", phone: 111-111-1111)
        customer.valid?.must_equal false
        customer.errors.messages.must_include :registered_at
    end


    it "can have address, city, state, postal_code, account_credit" do
        customer.address.must_equal customer.address
        customer.city.must_equal customer.city
        customer.state.must_equal customer.state
        customer.postal_code.must_equal customer.postal_code
        customer.account_credit.must_equal customer.account_credit
        customer.valid?.must_equal true
    end

    it "returns an array of rentals" do
        customer.rentals.each do |rental|
            rental.must_be_instance_of Rental
            rental.customer.must_equal customer
        end
    end

    it "returns an empty array if they have not rented a movie yet" do
        customer = Customer.create(name:"Gem", registered_at: "2017-05-09", phone: 111-111-1111)
        customer.rentals.must_equal []
    end

    it "returns an array of movies" do
        customer.movies.each do |movie|
            movie.must_be_instance_of Movie
            movie.customer.must_equal customer
        end
    end

    it "returns an empty array if they have not rented a movie yet" do
        customer = Customer.create(name:"Gem", registered_at: "2017-05-09", phone: 111-111-1111)
        customer.movies.must_equal []
    end

end
