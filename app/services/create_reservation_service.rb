# frozen_string_literal: true

class CreateReservationService
  WrongNumberOfTickets = Class.new(StandardError)
  UnevenAmountOfTickets = Class.new(StandardError)

  def initialize(event, count, options = {})
    @event = event
    @ticket = event.ticket
    @count = count
    @options = options
  end

  def call
    wrong_number_of_tickets?
    uneven_amount_of_tickets if options[:even]

    ActiveRecord::Base.transaction do
      ticket.lock!
      reservation = Reservation.create!(ticket_id: ticket.id, expires_at: reservation_expiration_timestamp)
      ticket.update(available: new_available_pool, reserved: count)
    end

  end

  private

  attr_reader :event, :ticket, :count, :options

  def reservation_expiration_timestamp
    DateTime.current + 15.minutes
  end

  def wrong_number_of_tickets?
    raise WrongNumberOfTickets, "Number of tickets must be greater than zero." unless count > 0
  end

  def uneven_amount_of_tickets
    raise UnevenAmountOfTickets, "Number of tickets must be even." unless count.even?
  end

  def new_available_pool
    ticket.available - count
  end
end
