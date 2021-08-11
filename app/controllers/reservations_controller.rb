# frozen_string_literal: true

class ReservationsController < ApiController
  def create
    CreateReservationService.new(find_event, tickets_count).call
  end

  private

  def find_event
    Event.find(params[:event_id])
  end

  def tickets_count
    params[:tickets_count]
  end
end
