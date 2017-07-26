class AddValueTrackToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :campaign_gid, :bigint
    add_column :visits, :feed_item_gid, :bigint
    add_column :visits, :target_gid, :string
    add_column :visits, :keyword_gid, :bigint
  end
end
