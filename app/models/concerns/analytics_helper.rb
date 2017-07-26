module AnalyticsHelper
  extend ActiveSupport::Concern

  module ClassMethods
    # def send_lead_e_commerce(lead, source, payout)
    #   uri = URI('http://www.google-analytics.com/collect')
    #
    #   http = Net::HTTP.new(uri.host, 80)
    #   http.use_ssl = false
    #
    #   request = Net::HTTP::Post.new(uri.path)
    #   request.content_type = 'application/x-www-form-urlencoded'
    #   request.body = URI.encode_www_form(
    #       {
    #           :v => 1,
    #           :tid => 'UA-58635914-1',
    #           :t => 'transaction',
    #           :cu => 'USD',
    #           :gclid => lead.visit.gclid,
    #           :cid => lead.token,
    #           :ti => lead.token + '-' + Time.now.to_s,
    #           :ta => source,
    #           :tr => payout,
    #           :uip => lead.visit.ip,
    #           :ua => lead.visit.browser
    #       }
    #   )
    #
    #   http.request(request)
    # end

    def send_lead_event(lead, source)
      uri = URI('http://www.google-analytics.com/collect')

      http = Net::HTTP.new(uri.host, 80)
      http.use_ssl = false

      request = Net::HTTP::Post.new(uri.path)
      request.content_type = 'application/x-www-form-urlencoded'
      request.body = URI.encode_www_form(
          {
              :v => 1,
              :tid => 'UA-58635914-1',
              :t => 'event',
              :ec => 'Lead',
              :ea => 'Convert',
              :ev => '1',
              :el => source,
              :gclid => lead.visit.gclid,
              :cid => lead.token,
              :uip => lead.visit.ip,
              :ua => lead.visit.browser
          }
      )

      http.request(request)
    end

    def send_e_commerce(product, source, payout)
      uri = URI('http://www.google-analytics.com/collect')

      http = Net::HTTP.new(uri.host, 80)
      http.use_ssl = false

      request = Net::HTTP::Post.new(uri.path)
      request.content_type = 'application/x-www-form-urlencoded'
      request.body = URI.encode_www_form(
          {
              :v => 1,
              :tid => 'UA-58635914-1',
              :t => 'transaction',
              :cu => 'USD',
              :gclid => product.visit.gclid,
              :cid => product.token,
              :ti => product.token + '-' + Time.now.to_s,
              :ta => source,
              :tr => payout,
              :uip => product.visit.ip,
              :ua => product.visit.browser
          }
      )

      http.request(request)
    end
  end


end