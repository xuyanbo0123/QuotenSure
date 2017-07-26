class AddRidToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :rid, :integer, :limit => 8
  end
end
