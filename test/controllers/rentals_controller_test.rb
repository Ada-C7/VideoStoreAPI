require "test_helper"

describe RentalsController do

  describe "Create (checkout)" do
    let(:customer) { customers(:good_data) }
    let(:movie) { movies(:psycho) }
    let(:customer2) { customers(:no_rentals)}

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

    it "cannot checkout movie with no available inventory" do
      post checkout_path("Lawrence of Arabia"), params: {
        customer_id: customer.id,
        due_date: Chronic.parse("two weeks from today")}
        proc {
          post checkout_path("Lawrence of Arabia"), params: {
            customer_id: customer.id,
            due_date: Chronic.parse("two weeks from today")}
          }.must_change 'Rental.count', 0
          must_respond_with 500


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

        it "decreases inventory of movie by 1" do
          proc {
            post checkout_path("Psycho"), params: {
              customer_id: Customer.all.first.id,
              due_date: Chronic.parse("two weeks from today")
            }
          }.must_change 'Movie.find_by_title("Psycho").available_inventory', -1

        end


        it "increases the customer's movies_checked_out_count by 1" do
          proc {
            post checkout_path(movie.title), params: {
              customer_id: customer.id,
              due_date: Chronic.parse("two weeks from today")
            }
          }.must_change 'customer.movies_checked_out_count', 1
        end

      end


      describe "check_in" do
        let(:rental) { rentals(:one) }
        let(:customer) { customers(:good_data) }
        let(:movie) { movies(:psycho) }
        let(:customer2) { customers(:no_rentals)}

        it "succeeds for valid title and customer id" do
          #valid means: rental exists [and therefore movie and customer exist]
          post checkin_path(movie.title), params: { customer_id: customer.id }
          must_respond_with :success
        end

        it "modifies the db with today's date as checkin date" do
          post checkin_path(movie.title), params: { customer_id: customer.id }
          rental.checkin_date.must_equal Date.today
        end

        it "modifies the db" do
          proc {
            post checkin_path(movie.title), params: { customer_id: customer.id }
          }.must_change rental.checkin_date
        end

        it "decreases the customer's movies_checked_out_count by 1" do
          proc {
            post checkin_path(movie.title), params: { customer_id: customer.id }
          }.must_change 'customer.movies_checked_out_count', -1
        end

        it "increases the movie's available inventory count by 1" do
          proc {
            post checkin_path(movie.title), params: { customer_id: customer.id }
          }.must_change 'Movie.find_by_title("Psycho").available_inventory', 1
        end

        it "renders bad request for invalid customer id data" do
          post checkin_path(movie.title), params: { customer_id: (Customer.last.id + 1)}
          must_respond_with :bad_request
          body = JSON.parse(response.body)
          body["error"].must_include "customer"
        end

        it "does not change the customer's movies_checked_out_count with invalid data" do
          proc {
            post checkin_path(movie.title), params: { customer_id: (Customer.last.id + 1)}
          }.must_change 'customer.movies_checked_out_count', 0
        end

        it "renders bad request if movie not found" do
          post checkin_path("totally made up title"), params: { customer_id: customer.id }
          must_respond_with :bad_request
          body = JSON.parse(response.body)
          body["error"].must_include "movie"
        end

        it "renders a different message if rental does not exist" do
          #rental does not exist (customer does not actually have that movie checked out)
          post checkin_path(movie.title), params: { customer_id: customer2.id}
          must_respond_with :bad_request
          body = JSON.parse(response.body)
          body["error"].must_include "not checked out"
        end

        it "renders bad request for invalid customer id data" do
          post checkin_path(movie.title), params: { customer_id: (Customer.last.id + 1)}
          must_respond_with :bad_request
          body = JSON.parse(response.body)
          body["error"].must_include "customer"
        end



        it "renders bad request if movie not found" do
          post checkin_path("totally made up title"), params: { customer_id: customer.id }
          must_respond_with :bad_request
          body = JSON.parse(response.body)
          body["error"].must_include "movie"
        end

        it "renders a different message if rental does not exist" do
          #rental does not exist (customer does not actually have that movie checked out)
          post checkin_path(movie.title), params: { customer_id: customer2.id}
          must_respond_with :bad_request
          body = JSON.parse(response.body)
          body["error"].must_include "not checked out"
        end
      end


      describe "overdue" do

        it "should list customers with overdue titles" do
          get rentals_overdue_path
          must_respond_with :success
        end

        it "response  should be in json" do skip
        end


      end

    end
