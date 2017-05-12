require "test_helper"
require 'date'

describe Rental do

  before do
    @customer_id = customers(:good_customer).id
    @rental_info = {
                      movie_id: movies(:movie3).id,
                      customer_id: @customer_id,
                      check_out_date: Date.today,
                      due_date: Date.today + 3,
                      status: "checked out"
                   }
  end

  it "requires all attributes to create instance" do
    rental = Rental.new(@rental_info)
    rental.valid?.must_equal true
    rental.save
    Rental.find_by(customer_id: @customer_id ).wont_be_nil
  end

  it "wont create a rental if missing a needed attribute" do
    @rental_info.keys.each do |attribute|
      rental_info = @rental_info.dup
      rental_info.delete(attribute)
      rental = Rental.new(rental_info)
      rental.valid?.must_equal false
      rental.errors.wont_be_nil
    end
  end

  describe "self.overdue_movies" do

    it "returns instance of Array" do
      rental1 = Rental.new(@rental_info)
      rental1.save
      rental2 = Rental.new(@rental_info)
      rental2.save
      Rental.overdue_movies.must_be_kind_of Array
    end

    it "returns rentals with status overdue" do
      Rental.overdue_movies.each do |movie|
        movie.status.must_equal "overdue"
      end
    end

    it "returns empty array if no overdue rentals was found" do
      Rental.destroy_all
      Rental.overdue_movies.must_be_empty
    end

    it "returns rentals which due_date is before today" do
      Rental.overdue_movies.each do |movie|
        movie.due_date.must_be :<, Date.today
      end
    end
  end
end
