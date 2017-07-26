class AddRidToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :rid, :integer, :limit => 8
  end
end
