require "test_helper"

describe CustomersController do
  describe "index" do
    it "is a real working route" do
      get customers_url
      must_respond_with :success
    end

    it "returns json" do
      get customers_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get customers_url

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "shows all the customers" do
      get customers_url
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customers with exactly the required fields" do
      keys = %w(name phone registered_at)
      get customers_url
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end

    it "returns 200 if customers exist" do
      get customers_path
      must_respond_with :ok
    end

    it "returns 404 if customers do not exist" do
      Customer.all.destroy_all
      get customers_path
      must_respond_with :not_found
    end

  end
end


# describe "show" do
# # This bit is up to you!
# it "can get a pet" do
#   get pet_path(pets(:two).id)
#   must_respond_with :success
# end
#
# it "returns 204 no_content if pet doesn't exist" do
#   # id = Pet.last.id.to_i + 1
#   get pet_path(Pet.last.id + 1)
#   must_respond_with :not_found
# end
# end
#
# describe "create" do
# let(:pet_data) {
#   {
#     name: "Jack",
#     age: 7,
#     human: "Captain Barbossa"
#   }
# }
#
# it "Creates a new pet" do
#   assert_difference "Pet.count", 1 do
#     post pets_url, params: { pet: pet_data }
#     assert_response :success
#   end
#
#   body = JSON.parse(response.body)
#   body.must_be_kind_of Hash
#   body.must_include "id"
#
#   # Check that the ID matches
#   Pet.find(body["id"]).name.must_equal pet_data[:name]
# end
#
# it "Returns an error for an invalid pet" do
#   bad_data = pet_data.clone()
#   bad_data.delete(:name)
#   assert_no_difference "Pet.count" do
#     post pets_url, params: { pet: bad_data }
#     assert_response :bad_request
#   end
#
#   body = JSON.parse(response.body)
#   body.must_be_kind_of Hash
#   body.must_include "errors"
#   body["errors"].must_include "name"
# end
# end
# end
