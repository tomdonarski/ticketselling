class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.boolean :expired, null: false, default: false
      t.datetime :expires_at, null: false, default: DateTime.current

      t.timestamps
    end
  end
end
