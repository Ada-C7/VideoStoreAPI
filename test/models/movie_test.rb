require "test_helper"

describe Movie do
  let(:movie) { Movie.new }

  it "must be valid" do
    skip
    value(movie).must_be :valid?
  end
  it 'available inventory can not be greater than inventory' do
    skip
  end

  describe 'available_inventory' do
    it 'returns correct available inventory' do
      org_inventory = movies(:one).inventory - 1
      a_i = movies(:one).available_inventory

      puts '<<<<'
      puts org_inventory
      puts '<<<<'
      puts '<<<<'
      puts a_i
      puts '<<<<'

      org_inventory.must_equal movies(:one).available_inventory
    end
  end
end
