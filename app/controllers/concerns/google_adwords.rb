module GoogleAdwords
  extend ActiveSupport::Concern
  private

  TODAY_DEFINITION = {
      :selector => {
          :fields => %w(Date CampaignId Impressions Clicks Cost AveragePosition)
      },
      :report_name => 'campaign performance report',
      :report_type => 'CAMPAIGN_PERFORMANCE_REPORT',
      :download_format => 'CSV',
      :date_range_type => 'TODAY',
      :include_zero_impressions => false
  }

  ALL_TIME_DEFINITION = {
      :selector => {
          :fields => %w(Date CampaignId Impressions Clicks Cost AveragePosition)
      },
      :report_name => 'campaign performance report',
      :report_type => 'CAMPAIGN_PERFORMANCE_REPORT',
      :download_format => 'CSV',
      :date_range_type => 'ALL_TIME',
      :include_zero_impressions => false
  }

  LAST_7_DAYS_DEFINITION = {
      :selector => {
          :fields => %w(Date CampaignId Impressions Clicks Cost AveragePosition)
      },
      :report_name => 'campaign performance report',
      :report_type => 'CAMPAIGN_PERFORMANCE_REPORT',
      :download_format => 'CSV',
      :date_range_type => 'LAST_7_DAYS',
      :include_zero_impressions => false
  }

  # Returns the API version in use.
  def get_api_version
    :v201502
  end

  def get_client_customer_id
    '760-711-7365'
  end

  # Returns an API object.
  def get_adwords_api
    @api ||= create_adwords_api
  end

  # Creates an instance of AdWords API class. Uses a configuration file and
  # Rails config directory.
  def create_adwords_api
    config_filename = File.join(Rails.root, 'config', 'adwords_api.yml')
    @api = AdwordsApi::Api.new(config_filename)
  end
end