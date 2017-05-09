require "test_helper"


describe Customer do
  let(:good_data) {customers(:good_data) }
  let(:good_data_dupe) {customers(:good_data) }
  let(:bad_data) {customers(:bad_data) }
  let(:negative_account) {customers(:negative_account) }


  describe "validations" do

    it "must be able to create valid customer" do
      good_data.save.must_equal true
    end

    it "must be able to create valid customer and return corresponding data" do
      good_data.save
      good_data.name.must_equal "Ann D"
    end

    # it 'invalid without all parameters' do
    #   bad_data.must_equal false
    #   bad_data.errors.messages.must_include :city
    # end

    it 'invalid without all parameters' do
      customer_missing_name = good_data.save
      customer_missing_name.name = nil
      customer_missing_name.save.must_equal false
    end

    it 'customer requires a unique username and address (w/ city, state, zip) combo' do
      good_data.save!
      good_data_dupe.save.must_equal false
      good_data_dupe.errors.messages.must_include :name
      good_data_dupe.errors.messages.must_include :address
      good_data_dupe.errors.messages.must_include :city
      good_data_dupe.errors.messages.must_include :state
      good_data_dupe.errors.messages.must_include :postal_code
    end

    it 'cannot create customer with negative account credit' do
      negative_account.save.must_equal false
      negative_account.errors.messages.must_include :account_credit
    end

  end
end
