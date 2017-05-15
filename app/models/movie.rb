class Movie < ApplicationRecord

     validates :title, presence: { message: ': Can\'t find a movie without a    title.' },
          length: { minimum: 2 }
     # validates :status, inclusion: { in: [true, false], message: 'Are you coming? Or are abandoning us on our special day?' }
     #
     # validates :number_of_guests, presence: { message: 'It takes at least one to RSVP.' },
     #      numericality: { only_integer: true, message:  'Is it just you? Or do you have a +1?' }
     #
     # validates :second_guest, presence: { message: 'Don\'t forget about your +1.' }, if: :plus_one?, on: :update,
     #      uniqueness: { message: 'Oops. Looks like you\'ll need another +1. That particular +1 has already RSVP\'d.' }
     #
     # validates :paid, inclusion: { in: [true, false], message: 'Have you settled up?' }
end
