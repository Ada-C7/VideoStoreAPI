require "test_helper"
#four fields title, overview, release_date,inventory
describe Movie do
  let(:no_title) { Movie.new(title:"", overview:"this is a movie", release_date:"2005/05/25", inventory:5) }
  let(:no_release_date) { Movie.new(title:"2005/05/25", overview:"this is a movie", release_date:"", inventory:5) }
  let(:no_overview) { Movie.new(title:"2005/05/25", overview:"", release_date:"this is a movie", inventory:5) }
  let(:no_inventory) { Movie.new(title:"2005/05/25", overview:"words", release_date:"this is a movie") }

  let(:integer_title) { Movie.new(title:1, overview:"this is a movie", release_date:"2005/05/25", inventory:5) }
  let(:integer_overview) { Movie.new(title:"words", overview:1, release_date:"2005/05/25", inventory:5) }
  let(:string_inventory) { Movie.new(title:"title", overview:"this is a movie", release_date:"2005/05/25", inventory:"") }
  let(:bad_release) { Movie.new(title:"title", overview:"this is a movie", release_date:"20/05/25", inventory:5) }
  let(:good_release) { Movie.new(title:"title", overview:"this is a movie", release_date:"2005/05/25", inventory:5) }


describe "validates presence" do
  it "must have a title"do
  no_title.valid?.wont_equal true
  end

  it "must have a release_date"do
  no_release_date.valid?.wont_equal true
  end

  it "must have an overview"do
  no_overview.valid?.wont_equal true
  end

  it "must have an inventory"do
  no_inventory.valid?.wont_equal true
  end
end

describe "validates type" do
  it "requires title to be a string" do
    integer_title.valid?.wont_equal true
  end

  it "requires overview to be a string" do
    integer_overview.valid?.wont_equal true
  end

  it "requires inventory to be an integer" do
    string_inventory.valid?.wont_equal true
  end

  it "requires release_date to be in YYYY/MM/DD format" do
    bad_release.valid_date?(bad_release.release_date).wont_equal true
  end

  it "accepts a release_date  in YYYY/MM/DD format" do
    good_release.valid_date?(good_release.release_date).must_equal true
    puts good_release.release_date.class


  end
end



end
