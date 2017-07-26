class ChangeResponseToText < ActiveRecord::Migration
  def change
    change_column :leads, :response, :text
  end
end
