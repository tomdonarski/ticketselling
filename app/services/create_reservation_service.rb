# frozen_string_literal: true

class CreateReservationService
  WrongNumberOfTickets = Class.new(StandardError)
  UnevenAmountOfTickets = Class.new(StandardError)
  OnlyOneTicketWouldRemain = Class.new(StandardError)
  RequestedAmountUnavailable = Class.new(StandardError)

  def initialize(event, count)
    @event = event
    @ticket = event.ticket
    @count = count
  end

  def call
    wrong_number_of_tickets?
    requested_amount_unavailable?
    uneven_amount_of_tickets if ticket.even
    only_one_ticket_would_remain if ticket.avoid_one

    ActiveRecord::Base.transaction do
      ticket.lock!
      reservation = Reservation.create!(ticket_id: ticket.id, expires_at: reservation_expiration_timestamp)
      ticket.update(available: new_available_pool, reserved: count)
    end

  end

  private

  attr_reader :event, :ticket, :count

  def reservation_expiration_timestamp
    DateTime.current + 15.minutes
  end

  def wrong_number_of_tickets?
    raise WrongNumberOfTickets, "Number of tickets must be greater than zero." unless count > 0
  end

  def uneven_amount_of_tickets
    raise UnevenAmountOfTickets, "Number of tickets must be even." unless count.even?
  end

  def only_one_ticket_would_remain
    raise OnlyOneTicketWouldRemain, "Please change requested amount." unless new_available_pool != 1
  end

  def requested_amount_unavailable?
    raise RequestedAmountUnavailable, "Sorry, requested amount is too big." unless availablility_check
  end

  def new_available_pool
    ticket.available - count
  end

  def availablility_check
    ticket.available >= count
  end
end
