require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  describe 'validations' do
    it 'can be created with all attributes' do
      @all_fields.valid?.must_equal true
    end

    it 'cannot be created without a title' do # validaiton for :title
      @missing_title.valid?.must_equal false
      # movie.errors.messages.must_include :title
    end

    it "must have a unique title" do
      # Fixture w/ title: "same title"
      @same_title.valid?.must_equal true

      dupe_book = Book.create!(title: "Same Title")
      dupe_book.valid?.must_equal false
    end
  end
end
