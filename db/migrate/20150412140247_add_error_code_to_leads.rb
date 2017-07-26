class AddErrorCodeToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :error_code, :string
    add_index :leads, :error_code
  end
end