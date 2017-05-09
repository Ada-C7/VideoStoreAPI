require "test_helper"


describe Customer do
  let(:good_data) {customers(:good_data) }
  let(:good_data_dupe) {customers(:good_data) }
  let(:bad_data) {customers(:bad_data) }
  let(:negative_account) {customers(:negative_account) }


  describe "validations" do

    it "must be able to create valid customer" do
      good_data.must_be :valid?
    end

    it 'invalid without all parameters' do
      bad_data.must_equal false
      bad_data.errors.messages.must_include :city
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
      good_data_dupe.errors.messages.must_include :account_credit
    end

  end
end
