class AddTicketCountToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :ticket_count, :integer, null: false
  end
end
