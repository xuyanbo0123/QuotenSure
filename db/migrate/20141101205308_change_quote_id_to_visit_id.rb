class ChangeQuoteIdToVisitId < ActiveRecord::Migration
  def change
    remove_index :leads, :quote_id
    remove_column :leads, :quote_id
    add_column :leads, :visit_id, :integer
    add_index :leads, :visit_id
  end
end
