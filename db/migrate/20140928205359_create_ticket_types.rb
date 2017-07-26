class CreateTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_types do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :ticket_types, :name
    add_index :ticket_types, :moss
  end
end

