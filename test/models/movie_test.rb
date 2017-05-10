require 'test_helper'

describe Movie do
    describe 'associations/relation' do
        it 'has many movies' do
            ar = Movie.reflect_on_association(:customers)
            ar.macro.must_equal :has_many
        end
        it "has many rentals" do
          ar = Movie.reflect_on_association(:rentals)
          ar.macro.must_equal :has_many
        end
    end
end
