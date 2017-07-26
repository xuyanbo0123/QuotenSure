class Revenue < ActiveRecord::Base
  include CommonScopes
  include AnalyticsHelper

  enum r_type: [:_lead, :_click]

  after_save :send_to_analytics

  def send_to_analytics
    if self._lead?
      lead = Lead.find_by_token(self.token)
      Revenue.send_e_commerce(lead, self.source, self.amount)
    elsif self._click?
      ad_request = AdRequest.find_by_token(self.token)
      Revenue.send_e_commerce(ad_request, self.source, self.amount)
    end
  end
end
