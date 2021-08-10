class RemoveAvailableFromTickets < ActiveRecord::Migration[6.0]
  def change
    remove_column :tickets, :available, :integer
  end
end
