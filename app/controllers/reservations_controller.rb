# frozen_string_literal: true

class ReservationsController < ApiController
  def create

    CreateReservationService.new(find_tickets, options).call
  end

  private

  def find_tickets
    Ticket.find(params[:ticket_ids])
  end

  def options
    {
      even: params[:even],
      avoid_one: params[:avoid_one],
    }
  end
end
