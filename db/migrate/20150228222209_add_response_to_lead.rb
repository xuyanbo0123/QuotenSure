class AddResponseToLead < ActiveRecord::Migration
  def change
    add_column :leads, :response, :string
  end
end
