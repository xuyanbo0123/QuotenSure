class AdGroup < ActiveRecord::Base
  belongs_to :campaign, foreign_key: :campaign_gid, primary_key: :gid

  has_many :ad_group_keywords, foreign_key: :ad_group_gid, primary_key: :gid

  def campaign_name
    if campaign.present?
      campaign.name
    else
      'N/A'
    end
  end

  private

  def self.sync(response)
    if response[:entries]
      response[:entries].each do |api_ad_group|
        ad_group = AdGroup.find_or_initialize_by(gid: api_ad_group[:id])
        ad_group.update(campaign_gid:api_ad_group[:campaign_id], name: api_ad_group[:name], status: api_ad_group[:status])
      end
    end
  end

end
