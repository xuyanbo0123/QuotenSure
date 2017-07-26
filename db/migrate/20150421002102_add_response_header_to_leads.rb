class AddResponseHeaderToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :response_header, :string
  end
end
