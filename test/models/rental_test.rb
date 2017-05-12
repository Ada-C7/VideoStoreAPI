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

  # does this need its own describ block
  describe 'check_inventory' do
    before do
      # @movie_not_available = movies(:movie_not_available)
      @customer = customers(:good_customer2)
      @bad_rental = {
                      customer_id: @customer.id,
                      movie_id: movies(:movie_not_available).id,
                      check_out_date: Date.today,
                      due_date: Date.today + 3
                     }

      # @movie_one_copy = movies(:movie_one_copy)
      @good_rental = {
                      customer_id: @customer.id,
                      movie_id: movies(:movie_one_copy).id,
                      check_out_date: Date.today,
                      due_date: Date.today + 3
                     }
    end

    # edge case 1 in inventory - 1 available
    it "will validate a rental if there is enough inventory (1 to 1)" do
      rental = Rental.new(@good_rental)
      rental.valid?.must_equal true
    end

    it "wont validate a rental if there is not enough inventory" do
      rental = Rental.new(@bad_rental)
      rental.valid?.must_equal false
      rental.errors.messages.must_include :movie_id
    end
  end
end
