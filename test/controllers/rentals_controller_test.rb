require "test_helper"

describe RentalsController do
    let(:rental_data) {
  { movie_id: movies(:one),
    customer_id: customers(:three).id,
    due_date: '2017-05-06'
  }
  }

  describe "Checkout" do

    it "Creates a new rental record" do
      # binding.pry
      proc {
        post checkout_path(movies(:one).title), params: {customer_id: customers(:three).id, movie_id: movies(:two).id, due_date: '2017-05-06'
        }
        # binding.pry
      }.must_change "Rental.count", 1
      must_respond_with :success
    end

    it "Won't checkout a movie if a movie doesn't exit" do
      proc {
        post checkout_path(title: "not_found"), params: rental_data
      }.must_change "Rental.count",0

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_include "errors"
      body["errors"].must_equal "title" => ["Movie 'not_found' not found"]
    end

    it "Gives error message if due_date was missing" do
      # binding.pry
      proc{
        post checkout_path(movies(:one).title), params: {customer_id: customers(:three).id, movie_id: movies(:two).id, due_date: nil}
      }.must_change "Rental.count", 0
      # binding.pry
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_equal "errors" => {"due_date" => ["can't be blank"]}
    end

    it "Bad request error for when a customer does not exist" do
      proc {
        post checkout_path(movies(:one).title), params: {customer_id: "no customer", movie_id: movies(:two).id, due_date: '2017-05-06'
        }
      }.wont_change 'Rental.count'
      must_respond_with :bad_request

      body = JSON.parse(response.body)
      body.must_equal "errors" => ["Customer 'no customer' not found"]
    end

    it "Updates available inventory when movie is rented" do
      movie = movies(:one)
      post checkout_path(movie.title), params: rental_data
      update = Movie.find_by_title(movie.title)
      update.available_inventory.must_equal (movie.available_inventory - 1)
    end

    it "Due date must be an actual date" do
      # due date must be a date DateTime.parse(params[:due_date])
      # checkout_path(movies(:one).title), params: {customer_id: customers(:three).id, movie_id: movies(:two).id, due_date: '2017-05-06'}
      #
      #    DateTime.parse(params[:due_date].must_be_kind_of DateTime

    end
  end

  describe "Checkin" do
    let(:rental_data) {
    {movie_id: movies(:one), customer_id: customers(:three).id,
    returned: false}
  }
    it "Can checkin a checkout rental"  do
      post checkout_path(movies(:one).title), params:
      {customer_id: customers(:three).id, movie_id: movies(:two).id, due_date: '2017-05-06'
      }

      proc {
        post checkin_path(movies(:one).title), params:
        {customer_id: customers(:three).id, movie_id: movies(:two).id
        }
      }.wont_change 'Rental.count'
      must_respond_with :success

      body = JSON.parse(response.body)
      body.must_include "id"
      body.must_include "checkin_date"

      Rental.last.checkin_date.wont_be_nil
    end

    it "Updates available inventory when movie is returned" do
      movie = movies(:one)
      post checkout_path(movie.title), params: rental_data

      post checkin_path(movie.title)
      update = Movie.find_by_title(movie.title)

      update.available_inventory.must_equal 4
    end

    it "Won't check in a movie that doesn't exist" do

      proc {
        post checkin_path(title: "not_found"), params: rental_data
      }.must_change "Rental.count",0

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_include "errors"
      body["errors"].must_equal "title" => ["Movie 'not_found' not found"]
    end

      it "Bad request error for when a customer does not exist" do
        proc {
          post checkin_path(movies(:one).title), params: {customer_id: "no customer", movie_id: movies(:two).id
          }
        }.wont_change 'Rental.count'
        must_respond_with :bad_request

        body = JSON.parse(response.body)
        body.must_equal "errors" => ["Customer 'no customer' not found"]
      end
  end

end
