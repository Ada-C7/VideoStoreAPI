require "test_helper"

describe RentalsController do

  describe "overdue" do
    it "returns 200 if overdue rentals exit" do
      get overdue_path
      must_respond_with :ok
    end

    it "returns 404 if overdue rentals don't exit" do
      rentals = Rental.where(returned_date: nil)
      rentals.destroy_all
      get overdue_path
      must_respond_with :not_found
    end

    it "finds rental records with overdue movies" do
      get overdue_path
      body = JSON.parse(response.body)
      body.length.must_equal 2
    end

    it "returns an array of overdue movies" do
      get overdue_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "shows the overdue rentals sorted" do
      get overdue_path, params: { sort: "title"}
      body = JSON.parse(response.body)
      body.first["title"].must_equal "Little Mermaid"

      get overdue_path, params: { sort: "name"}
      body = JSON.parse(response.body)
      body.first["name"].must_equal "one"

      get overdue_path, params: { sort: "checkout_date"}
      body = JSON.parse(response.body)
      body.first["checkout_date"].must_equal "2014-05-12"

      get overdue_path, params: { sort: "due_date"}
      body = JSON.parse(response.body)
      body.first["due_date"].must_equal "2016-04-10"
    end

  end
end
