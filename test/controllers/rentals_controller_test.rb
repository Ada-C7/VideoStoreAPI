require "test_helper"

describe RentalsController do
  describe "checkout method" do
    it "can check out a movie" do
      movie_title = movies(:jaws).title
      first_count = Rental.count
      customer_id = customers(:curran).id
      rental_params = {
        rental: {
          customer_id: customer_id,
          due_date: "2017-07-01"
        }
      }
      post new_rental_path(movie_title), params: rental_params

      must_respond_with :success

      last_count = Rental.count
      first_count.must_equal last_count - 1
    end

    it "won't check out a movie that doesn't exist" do
      movie_title = "fred"
      first_count = Rental.count
      customer_id = customers(:curran).id
      rental_params = {
        rental: {
          customer_id: customer_id,
          due_date: "2017-07-01"
        }
      }
      post new_rental_path(movie_title), params: rental_params
      must_respond_with :bad_request
      last_count = Rental.count
      first_count.must_equal last_count
    end


    it "won't check out a movie if a customer doesn't exist" do
      movie = movies(:jaws)
      first_count = Rental.count
      customer_id = Customer.last.id + 1
      rental_params = {
        rental: {
          customer_id: customer_id,
          due_date: "2017-07-01"
        }
      }
      post new_rental_path(movie.title), params: rental_params
      must_respond_with :bad_request
      last_count = Rental.count
      first_count.must_equal last_count
    end
  end


  describe "checkin method" do
    it "can check in a checked_out rental" do
      rental = rentals(:one)
      title = rental.movie.title
      id = customers(:shelley).id

      rental.checked_out.must_equal true

      rental_params = {
        rental: {
          customer_id: id
        }
      }

      post check_in_rental_path(title),  params: rental_params
      must_respond_with :success
      rental.reload
      rental.checked_out.must_equal false
    end

    it "gives an approriate error message and status bad request if given a bogus movie title" do

      title = 'Bogus Movie'
      id = customers(:shelley).id
      rental_params = {
        rental: {
          customer_id: id
        }
      }
      post check_in_rental_path(title),  params: rental_params
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      error_hash = { "error" => "Bogus Movie could not be found, so we could not check in your rental."}
      body.must_equal error_hash
    end

    it "gives an approriate error message and status bad request if given a bogus customer id" do
      id = Customer.first.id + 1
      rental_params = {
        rental: {
          customer_id: id
        }
      }
      post check_in_rental_path("Jaws"),  params: rental_params
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      error_hash = { "error" => "There was a problem. Could not check in your movie."}
      body.must_equal error_hash
    end

  end

  describe "overdue method" do
    it "succeeds and returns a list of overdue rentals" do
    get overdue_path
    must_respond_with :success
    overdue_item_info = [{"title"=>"Psycho", "customer_id"=>888622154, "name"=>"Shelley Rocha", "postal_code"=>"24309", "due_date"=>"2017-05-09", "checkout_date"=>"2017-05-12"}]
    body = JSON.parse(response.body)
    body.must_equal overdue_item_info
    end

    it "gives and appropriate message and status not found if there are no overdue rentals" do
      rental = rentals(:one)
      rental.checked_out = false
      rental.save
      get overdue_path
      must_respond_with :not_found
      body = JSON.parse(response.body)
      error_hash = { "no_overdue_rentals" => "There are no overdue rentals."}
      body.must_equal error_hash
    end
  end

  describe "sort overdue method" do

    it "can sort by movie title" do
      get overdue_path, params: { "sort": "title"}
      must_respond_with :success
      body = JSON.parse(response.body)

      body[0]["title"].must_equal "Jaws"
    end

    it "can sort by checkout date" do
      get overdue_path, params: { "sort": "checkout_date"}
      must_respond_with :success
      body = JSON.parse(response.body)

      body[0]["title"].must_equal "Psycho"
    end

    it "can sort by customer name" do
      get overdue_path, params: { "sort": "name"}
      must_respond_with :success
      body = JSON.parse(response.body)

      body[0]["title"].must_equal "Psycho"
    end

    it "can sort by due_date" do
      get overdue_path, params: { "sort": "due_date"}
      must_respond_with :success
      body = JSON.parse(response.body)

      body[0]["title"].must_equal "Psycho"
    end
  end

end
