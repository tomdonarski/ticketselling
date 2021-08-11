# frozen_string_literal: true

class ReservationsController < ApiController
  def create
    CreateReservationService.new(find_tickets).call
  end

  private

  def find_tickets
    Ticket.find(params[:ticket_ids])
  end
end
