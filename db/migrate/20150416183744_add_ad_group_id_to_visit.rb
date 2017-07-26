class AddAdGroupIdToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :ad_group_id, :bigint
  end
end
