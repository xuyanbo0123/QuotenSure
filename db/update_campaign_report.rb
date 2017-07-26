# campaign_reports
CampaignReport.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('campaign_reports')
CampaignReport.copy_from 'db/report/campaign_report.csv'