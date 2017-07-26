class AddDefaultValueToVehicles < ActiveRecord::Migration
  def change
    change_column :vehicles, :commute_day_id, :integer, :default => 6
  end
end
