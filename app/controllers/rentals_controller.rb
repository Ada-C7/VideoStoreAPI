class RentalsController < ApplicationController

  def create
    movie = Movie.find_by_title(params[:title])
    # if movie.inventory < 1
    #   render status: :error, json: { error: "not enough inventory"}
    # end

    if movie.nil? || movie.inventory < 1
      id = 0
    else
      id = movie.id
    end

    @rental = Rental.new(movie_id: id, customer_id: rental_params[:customer_id], due_date: rental_params[:due_date] )

    if @rental.save
      render status: :ok, json: @rental.as_json
    else
      # @rental.errors.full_messages.each do |message|
      #   puts message
      # end
      render status: :error, json: { error: @rental.errors.full_messages }
    end


  end

  private

  def rental_params
    params.permit(:customer_id, :due_date)
  end

end
