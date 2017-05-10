require "test_helper"

describe CustomersController do

  describe "index" do

    it "is a real working route" do
      skip
      must_respond_with :success
    end
  end
end

    # T_T: this belongs in Movies Controller (after we make one)
    #
    # describe 'Movies#all' do
    #   it "must return a collection of Movies" do
    #   end
    #
    #   it "returns empty Array when no movies exist" do
    #   end
    # end
    #
    # describe 'Movies#create' do
    #   it "adds a movie to our active record" do
    #   end
    # end
    #
    # describe 'Movies#find' do
    #   it "finds one Movie with a valid title" do
    #   end
    #
    #   it "find an empty array with a nonexistant title" do
    #   end
    # end
