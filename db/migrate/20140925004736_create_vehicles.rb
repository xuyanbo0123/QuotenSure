class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.integer :year
      t.string :make
      t.string :model
      t.string :trim
      t.integer :owner_type_id
      t.integer :vehicle_use_id
      t.integer :annual_mileage_id
      t.integer :commute_days
      t.integer :daily_mileage
      t.integer :garage_type_id
      t.integer :coll_deduct_id
      t.integer :comp_deduct_id

      t.integer :lead_id

      t.timestamps
    end
    add_index :vehicles, :owner_type_id
    add_index :vehicles, :vehicle_use_id
    add_index :vehicles, :annual_mileage_id
    add_index :vehicles, :garage_type_id
    add_index :vehicles, :coll_deduct_id
    add_index :vehicles, :comp_deduct_id

    add_index :vehicles, :lead_id
  end
end
