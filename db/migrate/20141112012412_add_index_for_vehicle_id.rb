class AddIndexForVehicleId < ActiveRecord::Migration
  def change
    add_index :drivers, :vehicle_id
  end
end
