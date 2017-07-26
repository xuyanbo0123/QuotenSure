class CreateVehicleUses < ActiveRecord::Migration
  def change
    create_table :vehicle_uses do |t|
      t.string :name
      t.string :moss

      t.timestamps null: false
    end
    add_index :vehicle_uses, :name
    add_index :vehicle_uses, :moss
  end
end
