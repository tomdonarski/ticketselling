# frozen_string_literal: true

class CreateReservationService
  TicketAlreadyReserved = Class.new(StandardError)

  def initialize(tickets, options = {})
    @tickets = tickets
  end

  def call
    ActiveRecord::Base.transaction do
      reservation = Reservation.create!(expires_at: reservation_expiration_timestamp)

      tickets.each do |ticket|
        raise TicketAlreadyReserved, "At least one of the tickets is already reserved" unless ticket.available?

        ReservedTicket.create!(reservation: reservation, ticket: ticket)
        ticket.lock!
        ticket.update!(status: "reserved")
      end
    end

  end

  private

  attr_reader :tickets

  def reservation_expiration_timestamp
    DateTime.current + 15.minutes
  end
end
