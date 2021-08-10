class AddStatusToTickets < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE processing_status AS ENUM ('available', 'reserved', 'processed', 'sold');
    SQL
    add_column :tickets, :status, :processing_status, null: false, default: 'available'
    add_index :tickets, :status
  end
  def down
    remove_column :tickets, :status
    execute <<-SQL
      DROP TYPE processing_status;
    SQL
  end
end
