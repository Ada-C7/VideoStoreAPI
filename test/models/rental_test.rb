require 'test_helper'

describe Rental do
  describe 'associations/relation' do
      it 'belongs to customers' do
          ar = Rental.reflect_on_association(:customer)
          ar.macro.must_equal :belongs_to
      end
      it 'belongs to movies' do
          ar = Rental.reflect_on_association(:movie)
          ar.macro.must_equal :belongs_to
      end
    end
end
