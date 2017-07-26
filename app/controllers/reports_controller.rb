require 'adwords_api'
require 'csv'

class ReportsController < ApplicationController
  include GoogleAdwords
  layout 'admin'
  http_basic_authenticate_with name: Rails.application.secrets.user, password: Rails.application.secrets.password
  before_action :sync_7_days, only: [:today, :daily, :daily_all]

  def index
    sync_campaign_report(ALL_TIME_DEFINITION)
    @campaign_reports = CampaignReport.order(day: :asc)
  end

  def today
    @reports ||= []
    @reports << Report.new(Time.zone.now.to_date-1.day)
    @reports << Report.new(Time.zone.now.to_date)
  end

  def daily
    days = (params[:d] || '7').to_i
    @reports ||= []
    days.times do |i|
      @reports << Report.new((days-i-1).day.ago.to_date)
    end
  end

  def daily_all
    @reports = CampaignReport.daily
  end

  private
  def sync_7_days
    sync_campaign_report(TODAY_DEFINITION)
    sync_campaign_report(LAST_7_DAYS_DEFINITION)
  end

  def sync_campaign_report(definition)
    rows = request_report(definition)
    if rows
      CampaignReport.sync(skip_headers(rows))
    end
  end

  def request_report(definition)
    api = get_adwords_api
    result = nil
    begin
      response = api.report_utils.download_report(definition)
      result = CSV.parse(response)
    rescue AdwordsApi::Errors::ReportError => e
      @error = e.message
    end
    result
  end

  def skip_headers(rows)
    if rows.present?
      rows[2..rows.length-2]
    end
  end
end