class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.integer :driver_id
      t.integer :rid, :limit => 8
      t.integer :incident_type_id
      t.integer :ticket_type_id
      t.integer :claim_type_id
      t.integer :accident_type_id
      t.integer :year
      t.integer :month
      t.boolean :at_fault
      t.integer :damage_type_id
      t.decimal :paid_amount
      t.string :state

      t.timestamps null: false
    end
    add_index :incidents, :driver_id
    add_index :incidents, :rid
    add_index :incidents, :incident_type_id
    add_index :incidents, :ticket_type_id
    add_index :incidents, :claim_type_id
    add_index :incidents, :accident_type_id
    add_index :incidents, :damage_type_id
  end
end
