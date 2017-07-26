class AddAdGroupIdToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :ad_group_id, :bigint
  end
end
