class Movie < ApplicationRecord
  has_many :customers, through: :rentals

  attr_reader :title, :overview, :release_date, :inventory

  def initialize(movie_data)
    @title = movie_data[:title]
    @overview = movie_data[:overview]
    @release_date = movie_data[:release_date]
    @inventory = movie_data[:inventory]
  end

end
