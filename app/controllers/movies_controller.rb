class MoviesController < ApplicationController
  def index
    movies = Movie.all
    sort_list = ["title", "release_date"]
    if sort_list.include?(params[:sort])
      movies = movies.sort_by{|movie| movie[params[:sort]]}
    end
    render json: movies, status: :ok
  end

  def show
    # movie = Movie.where(title: params[:title])
    title = params[:title]
    movie = Movie.where('lower(title) = ?', title.downcase)


    if movie.empty?
      render json: { errors: [{title: "Movie '#{params[:title]}' not found"}]}.to_json, status: :not_found
    else
      render json: movie.first, status: :ok, serializer: DetailedMovieSerializer
    end
  end


  def checkout
    title = params[:title]
    movie = Movie.find_by('lower(title) = ?', title.downcase)
    due_date = Time.now + 3.days
    rental = Rental.new(customer_id: params[:customer_id], movie_id: movie.id, due_date: due_date)
    if rental.save
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
      not_returned = []
      rentals.each do |rental|
        not_returned << rental if rental.returned_date == nil
      end

      if not_returned == []
        render json: {errors: "All movies are already returned"}, status: :not_found
      else
        oldest = "3000-05-14 20:19:19 -0700"
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


  private
  def movie_params
    params.require(:movie).permit(:name, :age, :human)
  end

end
