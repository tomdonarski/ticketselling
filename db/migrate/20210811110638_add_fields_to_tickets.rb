class AddFieldsToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :reserved, :integer, null: false, default: 0
    add_column :tickets, :sold, :integer, null: false, default: 0
  end
end
