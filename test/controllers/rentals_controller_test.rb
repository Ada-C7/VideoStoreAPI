require "test_helper"

describe RentalsController do

  describe "Create (checkout)" do

    it "given valid customer id and movie title, can checkout movie (increase rental record by 1)" do
    proc {
       post checkout_path("Psycho"), params: {
         customer_id: Customer.all.first.id, #this is going to AR to get the actual record but is talkign to the fixtures
         due_date: Chronic.parse("two weeks from today")

       }
     }.must_change 'Rental.count', 1
     must_respond_with :success
    end

    it "given invalid customer_id, cannot checkout movie" do
      proc {
         post checkout_path("Psycho"), params: {
           customer_id: Customer.all.last.id+1,
           due_date: Chronic.parse("two weeks from today")
         }
       }.must_change 'Rental.count', 0
       must_respond_with :error

       body = JSON.parse(response.body)
        body.must_be_kind_of Hash
        body.must_include "error"
    end

    it "given invalid movie_title, cannot checkout movie" do
      proc {
         post checkout_path("Psychosss"), params: {
           customer_id: Customer.all.first.id,
           due_date: Chronic.parse("two weeks from today")
         }
       }.must_change 'Rental.count', 0
       must_respond_with 500

       body = JSON.parse(response.body)
        body.must_be_kind_of Hash
        body.must_include "error"
    end

    it "can checkout a movie with enough inventory" do
      proc {
         post checkout_path("Psycho"), params: {
           customer_id: Customer.all.first.id,
           due_date: Chronic.parse("two weeks from today")
         }
       }.must_change 'Rental.count', 1
       must_respond_with :success
    end

    it "cannot checkout movie with no inventory" do
      proc {
         post checkout_path("Bring it On"), params: {
           customer_id: Customer.all.first.id,
           due_date: Chronic.parse("two weeks from today")
         }
        }.must_change 'Rental.count', 0
       must_respond_with 500

       body = JSON.parse(response.body)
        body.must_be_kind_of Hash
        body.must_include "error"

    end

    it "returns error when due date is in the past" do
      proc {
         post checkout_path("Psycho"), params: {
           customer_id: Customer.all.first.id,
           due_date: Chronic.parse("yesterday")
         }
       }.must_change 'Rental.count', 0
       must_respond_with 500

       body = JSON.parse(response.body)
        body.must_be_kind_of Hash
        body.must_include "error"


    end


  end
end
