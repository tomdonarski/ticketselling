# frozen_string_literal: true

class TicketPayment
  ReservationPaid = Class.new(StandardError)
  ReservationExpired = Class.new(StandardError)
  # NotEnoughTicketsError = Class.new(StandardError)

  def self.call(reservation, payment_token)
    raise ReservationPaid, "Reservation is paid already." if reservation.paid
    raise ReservationExpired, "Reservation has expired." if reservation.expired

    DeleteReservationReleaseJobService.call(reservation.id)
    # available_tickets = ticket.available
    ticket = reservation.ticket
    reserved_tickets = ticket.reserved
    sold_tickets = ticket.sold
    # raise NotEnoughTicketsError, "Not enough tickets left." unless available_tickets >= tickets_count

    ActiveRecord::Base.transaction do
      Payment::Gateway.charge(amount: ticket.price, token: payment_token)
      ticket.lock!
      ticket.update!(
        reserved: reserved_tickets - reservation.ticket_count,
        sold: sold_tickets + reservation.ticket_count
      )
      reservation.update!(paid: true)
    end
  end
end
