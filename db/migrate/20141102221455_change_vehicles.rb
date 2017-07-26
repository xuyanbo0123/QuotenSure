class ChangeVehicles < ActiveRecord::Migration
  def change
    rename_column :vehicles, :commute_days, :commute_day_id
    add_index :vehicles, :commute_day_id
  end
end
