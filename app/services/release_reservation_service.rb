# frozen_string_literal: true

class ReleaseReservationService
  def initialize(reservation_id)
    @reservation = Reservation.find(reservation_id)
    @ticket = reservation.ticket
    @count = reservation.ticket_count
  end

  def call
    ActiveRecord::Base.transaction do
      ticket.lock!
      ticket.update!(available: updated_available_pool, reserved: updated_reserved_pool)
      reservation.update!(expired: true)
    end
  end

  private

  attr_reader :reservation, :ticket, :count

  def updated_available_pool
    ticket.available + count
  end

  def updated_reserved_pool
    ticket.reserved - count
  end
end
