class CampaignReport < ActiveRecord::Base
  belongs_to :campaign, foreign_key: :campaign_gid, primary_key: :gid
  monetize :cost_cents

  def campaign_name
    if campaign.present?
      campaign.name
    else
      'N/A'
    end
  end

  def ctr
    impressions > 0 ? clicks / impressions.to_f : nil
  end

  def self.daily
    CampaignReport.select('day, sum(impressions) as impressions, sum(clicks) as clicks, sum(cost_cents) as cost_cents').group(:day).order(day: :asc)
  end

  def self.on_day(day)
    CampaignReport.select('day, sum(impressions) as impressions, sum(clicks) as clicks, sum(cost_cents) as cost_cents').where(day: day).order(day: :asc).group(:day).first
  end

  private

  def self.sync(rows)
    if rows
      # %w(Date CampaignId Impressions Clicks Cost AveragePosition)
      rows.each do |row|
        campaign_report = CampaignReport.find_or_initialize_by(day:row[0], campaign_gid: row[1])
        campaign_report.update(impressions: row[2], clicks: row[3], cost_cents: micros_to_cents(row[4].to_i), avg_position: row[5])
      end
    end
  end

  def self.micros_to_cents(micros)
    if micros.present?
      micros / 10000
    end
  end
end
