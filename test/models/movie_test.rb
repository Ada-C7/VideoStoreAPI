require 'test_helper'

describe Movie do
    describe 'associations/relation' do
        it 'has many movies' do
            ar = Movie.reflect_on_association(:customers)
            ar.macro.must_equal :has_and_belongs_to_many
        end
    end
end
