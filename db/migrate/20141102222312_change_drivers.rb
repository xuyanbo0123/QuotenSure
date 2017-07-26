class ChangeDrivers < ActiveRecord::Migration
  def change
    rename_column :drivers, :age_lic, :age_lic_id
    add_index :drivers, :age_lic_id
    remove_column :drivers, :sr22
    add_column :drivers, :is_sr22_id, :integer
    add_index :drivers, :is_sr22_id
  end
end
