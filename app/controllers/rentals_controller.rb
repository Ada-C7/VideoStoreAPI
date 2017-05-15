class RentalsController < ApplicationController
  before_action :find_movie
  before_action :find_customer

  def checkout
    due_date = params[:due_date]
    rental = Rental.new(due_date: due_date, customer_id: @customer.id, movie_id: @movie.id, returned: false)

    if @movie.available_inventory > 0
      @movie.available_inventory -= 1
      @movie.save
      if rental.save
        render status: :ok, json: rental.as_json(except: [:updated_at, :created_at])
      else
        render status: :bad_request, json: { errors: rental.errors.messages }
      end
    end
  end

  def checkin
    rental = Rental.find_by(customer_id: @customer.id, movie_id: @movie.id, returned: false)

    if @movie.available_inventory < @movie.inventory
      @movie.available_inventory += 1
      @movie.save

      rental.checkin_date = DateTime.now
      rental.returned = true

      if rental.save
        render status: :ok, json: rental.as_json(except: [:updated_at, :created_at])
      else
        render status: :bad_request, json: { errors: rental.errors.messages }
      end
    end
  end

  def overdue
    rentals = Rental.where(checkin_date: nil).where("due_date < ?", DateTime.now)

    rentals_overdue = []

    rentals.each do |rental|
      rentals_overdue << {
        checkout_date: rental.created_at, due_date: rental.due_date, title: rental.movie.title, customer_id: rental.customer.id, name: rental.customer.name, postal_code: rental.customer.postal_code
      }
    end

    if rentals_overdue.length > 0
      render status: :ok, json: rentals_overdue
    else
      render json: { nothing: true }, status: :not_found
    end
  end

  private

  def find_movie
    @movie = Movie.find_by(title: params[:title])
    if !@movie
      render json: {errors: {title: ["Movie '#{params[:title]}' not found"]} }, status: :not_found
    end
  end

  def find_customer
    @customer = Customer.find_by_id(params[:customer_id])
    if @customer.nil?
      render status: :bad_request, json: { errors: ["Customer '#{params[:customer_id]}' not found"]
    }
    end
  end
end
