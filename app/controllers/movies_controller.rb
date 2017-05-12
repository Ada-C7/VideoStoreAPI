class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render :json => movies.as_json(only: [:title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(title: params[:title])
    if movie
      render :json => movie, status: :ok
    else
      render :json => movie, status: :no_content
    end
  end

  def checkout
    movie = Movie.find_by(title: params[:title])
    movie.available_inventory -= 1
    movie.save

    customer = Customer.find_by(id: params[:customer_id])
    customer.movies_checked_out_count += 1
    customer.save
    
    rental = Rental.create(customer_id: customer.id, due_date: params[:due_date], movie_id: movie.id)
    render :json => rental, status: :ok
  end

end
