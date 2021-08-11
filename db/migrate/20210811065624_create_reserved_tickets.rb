class CreateReservedTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :reserved_tickets do |t|
      t.references :ticket, null: false, foreign_key: true, index: { unique: true }
      t.references :reservation, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
