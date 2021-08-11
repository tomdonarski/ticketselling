# frozen_string_literal: true

class ApiController < ApplicationController
  rescue_from TicketPayment::NotEnoughTicketsError, with: :conflict_error
  rescue_from Payment::Gateway::CardError, Payment::Gateway::PaymentError,
              with: :payment_failed_error
  rescue_from CreateReservationService::TicketAlreadyReserved, with: :conflict_error
  rescue_from CreateReservationService::UnevenAmountOfTickets, with: :conflict_error
  rescue_from CreateReservationService::WrongNumberOfTickets, with: :conflict_error

  private

  def conflict_error(error)
    render json: { error: error.message }, status: :conflict
  end

  def not_found_error(error)
    render json: { error: error.message }, status: :not_found
  end

  def payment_failed_error(error)
    render json: { error: error.message }, status: :payment_required
  end
end
