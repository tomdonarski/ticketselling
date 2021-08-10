# frozen_string_literal: true

class TicketsController < ApiController
  # before_action :set_event
  # before_action :set_tickets

  def index
    @tickets = Ticket.all

    render :index
  end

  def available_tickets
    @tickets = Ticket.available

    render :available_tickets
  end

  def reserved_tickets
    @tickets = Ticket.reserved

    render :reserved_tickets
  end

  def sold_tickets
    @tickets = Ticket.sold

    render :sold_tickets
  end

  def buy
    payment_token = params[:token]
    tickets_count = params[:tickets_count].to_i
    return wrong_number_of_tickets unless tickets_count > 0

    TicketPayment.call(@tickets, payment_token, tickets_count)
    render json: { success: "Payment succeeded." }
  end

  private

  def ticket_params
    params.permit(:event_id, :token, :tickets_count)
  end

  # def set_event
  #   @event = Event.find(params[:event_id])
  # rescue ActiveRecord::RecordNotFound => error
  #   not_found_error(error)
  # end
  #
  # def set_tickets
  #   @tickets = @event.ticket
  #   if @tickets.present?
  #     @tickets
  #   else
  #     render json: { error: "Ticket not found." }, status: :not_found
  #   end
  # end

  def wrong_number_of_tickets
    render json: { error: "Number of tickets must be greater than zero." }, status: :unprocessable_entity
  end
end
