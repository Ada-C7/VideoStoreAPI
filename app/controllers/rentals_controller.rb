class RentalsController < ApplicationController


  def checkout
    # must associate title with rental
    rental = Rental.new
    rental.movie = Movie.find_by(title: params[:title])
    rental.customer = Customer.find_by(id: params[:customer_id])
    rental.checkout_date = Date.today
    rental.due_date = params[:due_date]

    if rental.movie.available?

      if rental.save
        rental.movie.decrease_available_inventory
        #binding.pry
        render status: :ok, json: { name: rental.customer.name, customer_id: rental.customer.id, movie: rental.movie.title, checkout_date: rental.checkout_date, due_date: rental.due_date }
      else
        render status: :bad_request, json: { errors: rental.errors.messages }
      end
    else
      render status: :bad_request, json: { errors: "'#{rental.movie.title}' is not available to be checked out" }
    end

    # must decrement title inventory

    # must reference date
    # Date.parse("2014-1-1")
    # Date.today
    # Date.strptime("%m/%d/%Y")
  end

  def checkin
    # must reference the date
    # must increment title inventory
  end

  def overdue?

    # must reference
    # must reference the date plus default counter of days from checked_out-date
    # must reference either check_in or checked_out? method equalling true or false
    # should return something like customer.rental.title.overdue? == true or false
    def overdue?
      Date.parse(self.duedate.to_s) < Date.today
    end
  end
end
