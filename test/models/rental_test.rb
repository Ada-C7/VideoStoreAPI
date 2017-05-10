require "test_helper"
require 'date'

describe Rental do

  before do
    @customer_id = customers(:good_customer).id
    @rental_info = {
                      movie_id: movies(:movie1).id,
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

  it "wont create a rental if missing an needed attribute" do
    # rental = @rental_info.dup
    @rental_info.keys.each do |attribute|
      rental_info = @rental_info.dup
      rental_info.delete(attribute)
      rental = Rental.new(rental_info)
      rental.valid?.must_equal false
      rental.errors.wont_be_nil
    end
  end
end
