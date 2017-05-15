class MoviesController < ApplicationController
  def index
    sort_list = ["title", "release_date"]
    if sort_list.include?(params[:sort])
      movies = Movie.paginate(page: params[:p], per_page: params[:n]).order(params[:sort])
    else
      movies = Movie.paginate(page: params[:p], per_page: params[:n])
    end
    if movies != []
      render json: movies, status: :ok
    else
      render json: {errors: "There are No Movies"}, status: :not_found
    end

  end


  def show
    title = params[:title]
    movie = Movie.where('lower(title) = ?', title.downcase)

    if movie.empty?
      render json: { errors: { title: "Movie' #{params[:title]}' not found" }}.to_json, status: :not_found
    else
      render json: movie.first, status: :ok, serializer: DetailedMovieSerializer
    end
  end


  def checkout
    title = params[:title]
    movie = Movie.find_by('lower(title) = ?', title.downcase)
    due_date = Time.now + 3.days
    rental = Rental.new(customer_id: params[:customer_id], movie_id: movie.id, due_date: due_date)

    if movie.available_inventory < 1
      render json: { errors: { unavailable: "All copies of '#{params[:title]}' have been rented" }}.to_json, status: :not_found
    elsif rental.save
      render json: rental, status: :ok
    else
      render json: {errors: rental.errors.messages}, status: :bad_request
    end
  end


  def checkin
    title = params[:title]
    movie = Movie.find_by('lower(title) = ?', title.downcase)
    rentals = Rental.where(movie_id: movie.id, customer_id: params[:customer_id])

    if rentals == []
      render json: {errors: "Cannot Find the Rental Records"}, status: :not_found
    else
      not_returned = rentals.where(returned_date: nil)


      if not_returned == []
        render json: {errors: "All movies are already returned"}, status: :not_found
      else
        #if the customer has checked out mutiple copies of the same movie, check in the movie with the earliest checkout date first.
        oldest = Time.now + 2.days
        not_returned.each do |rental|

          oldest = rental.due_date if rental.due_date < oldest
        end
        rental = Rental.find_by(movie_id: movie.id, customer_id: params[:customer_id], due_date: oldest)
        rental.returned_date = Time.now
        rental.save
        render json: rental, status: :ok
      end
    end
  end
end
