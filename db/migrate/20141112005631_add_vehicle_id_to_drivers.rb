class AddVehicleIdToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :vehicle_id, :integer
  end
end
