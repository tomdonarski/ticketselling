class AddPaidFlagToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :paid, :boolean, null: false, default: false
  end
end
