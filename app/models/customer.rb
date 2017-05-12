class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, :through => :rentals
  validates :name, presence: true

  def movies_count
    return 0
    # render :json => @count.to_json(:methods => :movies_checked_out_count)
  end
end
