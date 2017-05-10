require "test_helper"

describe Rental do
    let(:rental) { rentals(:one) }


    it "has a customer associated with it" do
        rental.customer.must_be_instance_of Customer
        rental.customer must_equal 'brenna'
    end

    it "has a movie associated with it" do
        rental.movie.must_be_instance_of Movie
        rental.movie.must_equal 'strange'
    end

    it "is valid object with checkout_date, due_date, customer and movie" do
        rental.valid? true
        rental.checkout_date.must_equal '2017-05-02'
        rental.due_date.must_equal '2017-05-09'
    end

    it "is invalid without a due_date" do
        rental = Rental.create(customer_id: customers(:alison), movie_id: movies(:strange), checkout_date: "2015-05-10")
        rental.valid? false
        rental.errors.messages.must_include :due_date

    end

    it "is invalid without a checkout_date" do
        rental = Rental.create(customer_id: customers(:alison), movie_id: movies(:strange), due_date: "2015-05-10")
        rental.valid? false
        rental.errors.messages.must_include :checkout_date
    end

    it "has a due_date that is one week from the checkout_date" do
        due_date = Date.parse(rental.due_date)
        checkout_date = Date.parse(rental.checkout_date)
        due_date[:mday].must_equal checkout_date[:mday] + 7
    end

    it "is invalid if the due_date is not one week from the checkout_date" do
        rental = Rental.create(customer_id: customers(:alison), movie_id: movies(:strange), due_date: "2015-05-10", checkout_date: "2015-05-1")
        rental.valid? false
        rental.errors.messages.must_include :due_date
    end

end
