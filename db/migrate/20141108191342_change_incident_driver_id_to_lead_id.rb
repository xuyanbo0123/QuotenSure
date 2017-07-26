class ChangeIncidentDriverIdToLeadId < ActiveRecord::Migration
  def change
    remove_index :incidents, :driver_id
    remove_column :incidents, :driver_id
    add_column :incidents, :lead_id, :integer
    add_index :incidents, :lead_id
    rename_column :incidents, :rid, :driver_rid
  end
end
