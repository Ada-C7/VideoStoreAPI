require "test_helper"

describe Movie do

  # it "must be valid" do
  #   value(movie).must_be :valid?
  # end

  describe "relationships" do

    it "has many rentals" do
      ar = Movie.reflect_on_association(:rentals)
      expect(ar.macro) == :has_many
    end
  end

  describe 'validations' do

    it 'is valid with all attributes' do
      movies(:best_case).valid?.must_equal true
    end

    it 'is invalid without a title' do
      movies(:z_missing_title).valid?.must_equal false
    end

    it "is invalid with a duplicate title" do
      # Fixture w/ title: "same title"
      movies(:same_title).valid?.must_equal true

      dupe_book = Movie.create(title: "Same Title")
      dupe_book.valid?.must_equal false
    end

    it "is valid with a valid inventory" do
      movies(:best_case).valid?.must_equal true
    end

    it "is valid with zero (0) inventory" do # edge case
      movies(:inv_zero).valid?.must_equal true
    end

    it "is invalid with negative (-1) inventory" do # edge case
      movies(:z_inv_negative).valid?.must_equal false
    end

    # because the inventory's datatype is integer on the model the float is converted to integer before the validation only_integer
    it "changes a float (1.5) to an integer" do # edge case
      movies(:z_inv_float).inventory.must_equal 1
    end
  end

  describe "set_available_inventory" do

    it "sets the available_inventory" do
      movie = movies(:best_case)
      movie.available_inventory.must_equal movie.inventory
    end

    it "allows the available_inventory to change if a movie has been rented" do
      # movie = movies(:best_case)
      # Rental.create(customer_id: 1, )
  end
end
