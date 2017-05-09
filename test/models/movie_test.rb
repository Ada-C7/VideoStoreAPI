require "test_helper"
#four fields title, overview, release_date,inventory
describe Movie do
  let(:no_title) { Movie.new(title:"", overview:"this is a movie", release_date:"2005/05/25", inventory:5) }
  let(:no_release_date) { Movie.new(title:"2005/05/25", overview:"this is a movie", release_date:"", inventory:5) }

  it "must have a title"do
  no_title.valid?.wont_equal true
  end

  it "must have a release_date"do
  no_release_date.valid?.wont_equal true
  end
end
