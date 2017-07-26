class AddLeadidTokenAndLeadidTcpaDisclosureToLead < ActiveRecord::Migration
  def change
    rename_column :leads, :lid, :leadid_token
    add_column :leads, :leadid_tcpa_disclosure, :boolean, default: true
  end
end
