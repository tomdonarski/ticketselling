class ReservationWorker
  include Sidekiq::Worker

  def perform(reservation_id)
    ReleaseReservationService.new(reservation_id).call
  end
end
