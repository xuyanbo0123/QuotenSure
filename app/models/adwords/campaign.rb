class Campaign < ActiveRecord::Base
  has_many :ad_groups, foreign_key: :campaign_gid, primary_key: :gid
  has_many :campaign_reports, foreign_key: :campaign_gid, primary_key: :gid

  private
  def self.sync(response)
    if response[:entries]
      response[:entries].each do |api_campaign|
        campaign = Campaign.find_or_initialize_by(gid: api_campaign[:id])
        campaign.update(name: api_campaign[:name], status: api_campaign[:status])
      end
    end
  end
end
