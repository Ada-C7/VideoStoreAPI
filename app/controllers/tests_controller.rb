class TestsController < ApplicationController
  def bla
    render json: { i_am_a_test: "zomg" }
  end
end
