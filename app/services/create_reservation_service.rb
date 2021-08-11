# frozen_string_literal: true

class CreateReservationService
  TicketAlreadyReserved = Class.new(StandardError)
  UnevenAmountOfTickets = Class.new(StandardError)
  WrongNumberOfTickets = Class.new(StandardError)

  def initialize(tickets, options = {})
    @tickets = tickets
    @options = options
  end

  def call
    wrong_number_of_tickets?
    uneven_amount_of_tickets if options[:even]

    ActiveRecord::Base.transaction do
      reservation = Reservation.create!(expires_at: reservation_expiration_timestamp)

      tickets.each do |ticket|
        raise TicketAlreadyReserved, "At least one of the tickets is already reserved." unless ticket.available?

        ReservedTicket.create!(reservation: reservation, ticket: ticket)
        ticket.lock!
        ticket.update!(status: "reserved")
      end
    end

  end

  private

  attr_reader :tickets, :options

  def reservation_expiration_timestamp
    DateTime.current + 15.minutes
  end

  def wrong_number_of_tickets?
    raise WrongNumberOfTickets, "Number of tickets must be greater than zero." unless tickets.count > 0
  end

  def uneven_amount_of_tickets
    raise UnevenAmountOfTickets, "Number of tickets must be even." unless tickets.count.even?
  end
end
