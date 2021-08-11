# frozen_string_literal: true

class DeleteReservationReleaseJobService
  def call(reservation_id)
    queue = Sidekiq::Queue.new
    queue.each do |job|
      job.delete if job.args.include?(reservation_id)
    end
  end
end
