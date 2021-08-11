class AddOptionsToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :even, :boolean, null: false, default: false
    add_column :tickets, :avoid_one, :boolean, null: false, default: false
  end
end
