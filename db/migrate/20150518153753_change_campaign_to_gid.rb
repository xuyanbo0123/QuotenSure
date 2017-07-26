class ChangeCampaignToGid < ActiveRecord::Migration
  def change
    remove_column :campaign_reports, :campaign
    add_column :campaign_reports, :campaign_gid , :integer, :limit => 8
  end
end
