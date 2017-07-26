class AddHasIncidentToLead < ActiveRecord::Migration
  def change
    add_column :leads, :has_incident, :boolean
    add_index :leads, :has_incident
  end
end
