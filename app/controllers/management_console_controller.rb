require 'adwords_api'

class ManagementConsoleController < ApplicationController
  include GoogleAdwords
  layout 'admin'
  http_basic_authenticate_with name: Rails.application.secrets.user, password: Rails.application.secrets.password

  PAGE_SIZE = 500

  def index
    sync_adwords

    @campaigns = Campaign.all
    @campaign_count = @campaigns.length

    @ad_groups = AdGroup.all.order(:id)
    @ad_group_count = @ad_groups.length

    @ad_group_keywords = AdGroupKeyword.all.order(:id)
    @ad_group_keyword_count = @ad_group_keywords.length
  end


  private

  def sync_adwords
    response = request_campaigns
    if response
      Campaign.sync(response)
    end
    response = request_ad_groups
    if response
      AdGroup.sync(response)
    end
    response = request_keywords
    if response
      AdGroupKeyword.sync(response)
    end
  end

  def request_campaigns
    api = get_adwords_api
    service = api.service(:CampaignService, get_api_version)
    selector = {
        :fields => ['Id', 'Name', 'Status'],
        :ordering => [{:field => 'Id', :sort_order => 'ASCENDING'}],
        :paging => {:start_index => 0, :number_results => PAGE_SIZE}
    }
    result = nil
    begin
      result = service.get(selector)
    rescue AdwordsApi::Errors::ApiException => e
      logger.fatal("Exception occurred: %s\n%s" % [e.to_s, e.message])
      flash.now[:alert] =
          'API request failed with an error, see logs for details'
    end
    result
  end

  def request_ad_groups
    api = get_adwords_api
    service = api.service(:AdGroupService, get_api_version)
    selector = {
        :fields => ['Id', 'CampaignId', 'Name', 'Status'],
        :ordering => [{:field => 'Id', :sort_order => 'ASCENDING'}],
        :paging => {:start_index => 0, :number_results => PAGE_SIZE}
    }
    result = nil
    begin
      result = service.get(selector)
    rescue AdwordsApi::Errors::ApiException => e
      logger.fatal("Exception occurred: %s\n%s" % [e.to_s, e.message])
      flash.now[:alert] =
          'API request failed with an error, see logs for details'
    end
    result
  end

  def request_keywords
    ad_group_gids = AdGroup.pluck(:gid)
    api = get_adwords_api
    service = api.service(:AdGroupCriterionService, get_api_version)
    selector = {
        :fields => ['Id', 'CriteriaType', 'AdGroupId', 'Status', 'FirstPageCpc', 'TopOfPageCpc', 'QualityScore', 'KeywordText', 'KeywordMatchType'],
        :ordering => [
            {:field => 'Id', :sort_order => 'ASCENDING'}
        ],
        :predicates => [
            {:field => 'AdGroupId', :operator => 'IN', :values => ad_group_gids},
            {:field => 'CriteriaType', :operator => 'EQUALS', :values => ['KEYWORD']}
        ],
        :paging => {
            :start_index => 0,
            :number_results => PAGE_SIZE
        }
    }
    result = nil
    begin
      result = service.get(selector)
    rescue AdwordsApi::Errors::ApiException => e
      logger.fatal("Exception occurred: %s\n%s" % [e.to_s, e.message])
      flash.now[:alert] =
          'API request failed with an error, see logs for details'
    end
    result
  end
end
