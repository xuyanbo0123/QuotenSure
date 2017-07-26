class AdGroupKeyword < ActiveRecord::Base
  belongs_to :ad_group, foreign_key: :ad_group_gid, primary_key: :gid

  def ad_group_name
    if ad_group.present?
      ad_group.name
    else
      'N/A'
    end
  end

  private

  def self.sync(response)
    if response[:entries]
      response[:entries].each do |api_keyword|
        keyword = AdGroupKeyword.find_or_initialize_by(gid: api_keyword[:criterion][:id])
        keyword.ad_group_gid = api_keyword[:ad_group_id]
        keyword.keyword = api_keyword[:criterion][:text]
        keyword.user_status = api_keyword[:user_status]
        keyword.match_type = api_keyword[:criterion][:match_type]
        if api_keyword[:quality_info].present?
          keyword.quality = api_keyword[:quality_info][:quality_score]
        end
        if api_keyword[:first_page_cpc].present?
          keyword.first_cpc = api_keyword[:first_page_cpc][:amount][:micro_amount]
        end
        if api_keyword[:top_of_page_cpc].present?
          keyword.top_cpc = api_keyword[:top_of_page_cpc][:amount][:micro_amount]
        end
        keyword.save
      end
    end
  end
end
