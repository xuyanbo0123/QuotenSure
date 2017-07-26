class ChangeAdGroupIdToAdGroupGid < ActiveRecord::Migration
  def change
      rename_column :visits, :ad_group_id, :ad_group_gid
      rename_column :brands, :ad_group_id, :ad_group_gid
  end
end
