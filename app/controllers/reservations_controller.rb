# frozen_string_literal: true

class ReservationsController < ApiController
  def create
    Reservation.create!(expires_at: DateTime.current + 15.minutes)
  end
end
