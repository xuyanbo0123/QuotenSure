class AdRequest < ActiveRecord::Base
  extend FriendlyId
  include CommonScopes
  friendly_id :token

  enum sender: [:_pop_under, :_after_form]

  belongs_to :visit
  has_many :ads

  validates :zip, presence: true

  before_save :set_city_state, :set_token

  def ordered_ads
    ads.order('id asc')
  end

  def featured_ads
    ads.order('id asc').first(2)
  end

  def other_ads
    ads.order('id asc').offset(2)
  end

  def fetch_ads
    begin
      self.set_city_state
      self.set_token
      self.fetch_vantage_media_ads
    rescue => e
      ErrorMailer.error_email('AdRequest.fetch_ads Error', e.message + 'attributes: ' + self.as_json.to_s).deliver
    end
  end

  def send_error_notification
    ErrorMailer.error_email('AdRequest Error', self.errors.full_messages + 'attributes: ' + self.as_json.to_s).deliver
  end

  def set_city_state(options = {})
    if self.zip.blank?
      criteria_id = options[:lp]
      if criteria_id.present?
        geo = GoogleGeo.find_by_criteria_id(criteria_id)
        parent_geo = GoogleGeo.find_by_criteria_id(geo.parent_id)

        if geo.target_type == 'City'
          self.city = geo.name
        elsif geo.target_type == 'State'
          self.state = geo.state_abbr
          @state_name = geo.name
        elsif geo.target_type == 'Postal Code'
          # self.zip = geo.name
        end

        if parent_geo.target_type == 'State'
          self.state = parent_geo.state_abbr
          @state_name = parent_geo.name
        end
      end
    else
      zip_code = ZipCode.find_by_zip(self.zip)
      if zip_code.present?
        self.city = zip_code.city
        self.state = zip_code.state
        @state_name = zip_code.state_name
      end
    end
  end

  def region_text
    if @state_name.blank?
      ''
    else
      ' in '+@state_name
    end
  end

  def get_city_state
    if self.city.blank?
      ''
    else
      self.city + ', ' +self.state
    end
  end

  def get_proper_city_state
    if self.city.blank?
      ''
    else
      self.city.titlecase + ', ' +self.state
    end
  end

  protected

  def set_token
    if self.token.nil?
      self.token=SecureRandom.uuid
    end
    self.ads.each_with_index do |ad, i|
      if ad.token.nil?
        ad.token = self.token + '-' + i.to_s
      end
    end
  end

  def fetch_vantage_media_ads
    uri = URI('http://marketplaces.vantagemedia.com/Search')

    http = Net::HTTP.new(uri.host, 80)
    http.use_ssl = false

    # params = {
    #     :adSource => self.token.to_s,
    #     :PublisherTrackingId => self.token.to_s.gsub('-', ''),
    #     :state => self.state,
    #     :zipCode => self.zip,
    #     :publisherId => 37585,
    #     :campaign => 25938,
    #     :maxResults => 8,
    #     :md => 4,
    #     :engagementOption => 1,
    #     :client_user_agent => self.visit.browser,
    #     :client_ip => self.visit.ip,
    #     :format => 'xml'
    # }

    if self._pop_under?
      params = {
          :adSource => self.token.to_s,
          :PublisherTrackingId => self.token.to_s.gsub('-', ''),
          :state => self.state,
          :zipCode => self.zip,
          :publisherId => 37585,
          :campaign => 25938,
          :maxResults => 8,
          :md => 4,
          :engagementOption => 1,
          :client_user_agent => self.visit.browser,
          :client_ip => self.visit.ip,
          :format => 'xml'
      }
    else
      params = {
          :adSource => self.token.to_s,
          :PublisherTrackingId => self.token.to_s.gsub('-', ''),
          :state => self.state,
          :zipCode => self.zip,
          :publisherId => 37585,
          :campaign => 25938,
          :maxResults => 8,
          :md => 4,
          :engagementOption => 1,
          :client_user_agent => self.visit.browser,
          :client_ip => self.visit.ip,

          :CurrentlyInsured => get_bw_currently_insured,
          'YearIncidentCount' => get_bw_3_year_incident_count,
          :MultiDriverHousehold => get_bw_multi_driver_household,
          :Age => get_bw_age,
          :Homeowner => get_bw_homeowner,
          :YearsOfCurrentCoverage => get_bw_years_of_coverage,
          :TargetCoverage => get_bw_target_coverage,
          :TargetBodilyInjuryLiabilityLimits => get_bw_target_bodily_injury,

          :format => 'xml'
      }
    end

    request = Net::HTTP::Get.new(uri.path+'?'+params.collect { |k, v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))
    request['accept-encoding'] ='none'

    response = http.request(request)
    self.response = response.body.to_s
    self.save!

    # sampleXmlStr = '<ListingsResult xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.datacontract.org/2004/07/Public.Commons.AbstractProtocol.EduSearch.Response"><OpenMatchListings /><ResponseStatus><Status xmlns="">Ok</Status></ResponseStatus><Results><OutPutListing xmlns=""><BrandName>LibertyMutual</BrandName><Description><Element>Helping People Live Safer, More Responsible Lives. </Element><Element>Providing Insurance Since 1912.</Element><Element>Get a Fast, Free Quote Online.</Element></Description><DescriptionType>Bulleted</DescriptionType><DisplayUrl>www.LibertyMutual.com</DisplayUrl><EngagementId>2973ecda-9a40-4246-aea7-f98327b862f6_43678</EngagementId><HeadLine>Liberty Mutual Auto Insurance</HeadLine><ListingId>43678</ListingId><LogoUrl>//images.vantage-media.net/logos/36767_804.gif?e=2973ecda-9a40-4246-aea7-f98327b862f6_43678&amp;pos=1</LogoUrl><Products><Product><ActionUrl>//marketplaces.vantagemedia.com/click/2973ecda-9a40-4246-aea7-f98327b862f6/43678/aHR0cDovL3dlbGNvbWUubGliZXJ0eW11dHVhbC5jb20vY2FtcGFpZ25zL2FnZ3JlZ2F0b3JzL3YyL2F1dG8taW5zdXJhbmNlLVRDLmh0bWw_Y21wZ25jZGU9MjUyJmtleUNvZGU9SUFCV0EwMDAmc3JjPWltLWRhZ2ctYXV0LWJyd01BMTQwNzEwMzY4MiZ6aXBDb2RlPTAyNDQ2JnBpZD17c291cmNlX2lkfSZjbGlja2lkPXtlbmdhZ2VtZW50aWR9Jmluc3VyZWQ9JmFnZT0maW5jaWRlbnQ9JmRyaXZlcnM9JmhvbWVvd25lcj0mY2l0eT1Ccm9va2xpbmUmc3RhdGU9TUEmYWRjb3B5PTI.</ActionUrl><Type>Click</Type></Product></Products></OutPutListing><OutPutListing xmlns=""><BrandName>Progressive</BrandName><Description><Element>Paying too much on auto insurance?  Drivers who switch to Progressive save an average of over $548. So get a free quote today to see how much you could save!</Element></Description><DescriptionType>Paragraph</DescriptionType><DisplayUrl>www.Progressive.com</DisplayUrl><EngagementId>2973ecda-9a40-4246-aea7-f98327b862f6_44044</EngagementId><HeadLine>Brookline, Massachusetts drivers, you could save hundreds on car insurance with Progressive</HeadLine><ListingId>44044</ListingId><LogoUrl>//images.vantage-media.net/logos/36889_936.gif?e=2973ecda-9a40-4246-aea7-f98327b862f6_44044&amp;pos=2</LogoUrl><Products><Product><ActionUrl>//marketplaces.vantagemedia.com/click/2973ecda-9a40-4246-aea7-f98327b862f6/44044/aHR0cDovL2FkLmRvdWJsZWNsaWNrLm5ldC9jbGs7MjUwMjkwMzc3Ozc1MTY0NTIyO2c7cGM9W1RQQVNfSURdP2h0dHA6Ly93d3cucHJvZ3Jlc3NpdmUuY29tL2luc3VyYW5jZS9zYS9hdXRvL2Jyb2tlcnN3ZWIvZGVmYXVsdC5hc3B4P2NvZGU9ODAxNDUwMDAwMSZ6aXBjb2RlPSZCV19TUkM9e2VuZ2FnZW1lbnRpZH0mYndpbnN1cmVkPQ..</ActionUrl><Type>Click</Type></Product></Products></OutPutListing><OutPutListing xmlns=""><BrandName>Allstate</BrandName><Description><Element>Take Advantage of our Discounts in Massachusetts</Element><Element>Get a Free Online Auto Insurance Quote in Minutes.</Element><Element>Drivers who Switched Saved an Average of $498!</Element><Element>Are You in Good Hands?</Element></Description><DescriptionType>Bulleted</DescriptionType><DisplayUrl>www.Allstate.com</DisplayUrl><EngagementId>2973ecda-9a40-4246-aea7-f98327b862f6_342974</EngagementId><HeadLine>Allstate&amp;reg; Auto Insurance</HeadLine><ListingId>342974</ListingId><LogoUrl>//images.vantage-media.net/logos/297297_28.gif?e=2973ecda-9a40-4246-aea7-f98327b862f6_342974&amp;pos=3</LogoUrl><Products><Product><ActionUrl>//marketplaces.vantagemedia.com/click/2973ecda-9a40-4246-aea7-f98327b862f6/342974/aHR0cDovL2NsaWNrc2VydmUuZGFydHNlYXJjaC5uZXQvbGluay9jbGljaz9saWQ9NDM3MDAwMDU2ODE1MTQ0MzAmZHNfc19rd2dpZD01ODcwMDAwMDM4Mjc2MTE2OSZkc191cmxfdj0yJmRzX2Rlc3RfdXJsPWh0dHA6Ly9tLnhwMS5ydTQuY29tL3NjbGljaz9fbz0xNTcxOSZfdD1kY3Mmc3N2X2tuc2hfdGlkPVsqR0NMSUQqXSZzc3Zfa25zaF9hZ2lkPVsqQWRncm91cElEKl0mc3N2X2tuc2hfY2lkPVsqQ2FtcGFpZ25JRCpdJnNzdl9rbnNoX2NyaWQ9bm9uZSZzc3Zfa25zaF9hZmZpZD1bKktleXdvcmRJRCpdJnNzdl9rbnNoX3Nlbj1WYW50YWdlTWVkaWEmc3N2X2tuc2hfbndrPVNlYXJjaCZyZWRpcmVjdD1odHRwOi8vbGFuZGluZy5hbGxzdGF0ZS5jb20vYXV0by9kZXNrdG9wL3QyP0NNUD1LTkMtVDItQlctQVUtMDI3MjM1LTE0MDkyNTpNQS1CVy1BVSZ0Zm49MTg2NjM2MDQyMDAmQ2FtcGFpZ249NDQ0NDkwMDAwMDI3MjM1</ActionUrl><Type>Click</Type></Product></Products></OutPutListing><OutPutListing xmlns=""><BrandName>Plymouth Rock</BrandName><Description><Element>24/7 online quotes and sign up</Element><Element>Comparison quotes from other top companies</Element><Element>24-hour claims service &amp; guaranteed repairs</Element><Element>Find out why 300,000 Massachusetts drivers rely on us. Quote now!</Element></Description><DescriptionType>Bulleted</DescriptionType><DisplayUrl>www.prac.com</DisplayUrl><EngagementId>2973ecda-9a40-4246-aea7-f98327b862f6_43918</EngagementId><HeadLine>We live, work and drive in MA too</HeadLine><ListingId>43918</ListingId><LogoUrl>//images.vantage-media.net/logos/36847_472.gif?e=2973ecda-9a40-4246-aea7-f98327b862f6_43918&amp;pos=4</LogoUrl><Products><Product><ActionUrl>//marketplaces.vantagemedia.com/click/2973ecda-9a40-4246-aea7-f98327b862f6/43918/aHR0cDovL2FkLmRvdWJsZWNsaWNrLm5ldC9jbGs7MjYyMzIzODQ3Ozg2NTU1MjQ3O3M_aHR0cHM6Ly9jaS5wcmFjLmNvbS9wcmFjL1BSQy9pbmRleC5qc3A_UExGX0NvZGU9UFJBQyZpUmVmaWQ9QlJXQiZpUmVmY2xpY2tpZD1jb21wMTIxMCZ6aXBjb2RlPQ..</ActionUrl><Type>Click</Type></Product></Products></OutPutListing></Results></ListingsResult>'
    xml = Nokogiri::XML(response.body.to_s[/<ListingsResult.+/].sub(/<ListingsResult.+?>/, '<ListingsResult>'))
    listings = xml.xpath('/ListingsResult/Results/OutPutListing')
    listings.each do |i|
      engagementId = i.xpath('EngagementId').text

      header = i.xpath('HeadLine').text
      logo_link = i.xpath('LogoUrl').text
      click_link = i.xpath('Products/Product/ActionUrl').text
      display_link = i.xpath('DisplayUrl').text

      content=''
      elements = i.xpath('Description/Element')
      elements.each_with_index do |e, index|
        content = content + e.text
        content = content + "\r\n" if index < elements.count-1
      end

      self.ads.create(
          :header => header,
          :content => content,
          :logo_link => logo_link,
          :click_link => click_link,
          :display_link => display_link
      )
    end
  end

  private

  def get_bw_currently_insured
    self.visit.leads.last.policy.is_insured_id
  end

  def get_bw_3_year_incident_count
    if self.visit.leads.last.incidents.count == 0
      '1'
    elsif self.visit.leads.last.incidents.count == 1
      '2'
    elsif self.visit.leads.last.incidents.count == 2
      '3'
    else
      '4'
    end
  end

  def get_bw_multi_driver_household
    if self.visit.leads.last.drivers.count >1
      '1'
    else
      '2'
    end
  end

  def get_bw_age
    age = Time.now.year - self.visit.leads.last.drivers.first.birthday.year + 1
    if age < 18
      '1'
    elsif age <= 24
      '2'
    elsif age <= 34
      '3'
    elsif age <= 49
      '4'
    elsif age <= 64
      '5'
    else
      '6'
    end
  end

  def get_bw_homeowner
    if self.visit.leads.last.contact.residence_status_id == 1
      '1'
    elsif self.visit.leads.last.contact.residence_status_id == 2
      '2'
    else
      '3'
    end
  end

  def get_bw_years_of_coverage
    if self.visit.leads.last.policy.continuous_year_id == 1
      '1'
    else
      '2'
    end
  end

  def get_bw_target_coverage
    self.visit.leads.last.policy.request_coverage_id
  end

  def get_bw_target_bodily_injury
    if self.visit.leads.last.policy.request_coverage_id == 1
      '6'
    elsif self.visit.leads.last.policy.request_coverage_id == 2
      '5'
    elsif self.visit.leads.last.policy.request_coverage_id == 3
      '3'
    else
      '1'
    end
  end

  # def http_get(domain, path, params)
  #   if params.nil?
  #     Net::HTTP.get(domain, path)
  #   else
  #     Net::HTTP.get(domain, "#{path}?".concat(params.collect { |k, v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')))
  #   end
  # end

  # http://www.onlineautoinsurance.com/get-quotes/async.php?option=2014&type=year
  # Be careful about 'port', 'ssl' and 'content_type'
  # def send_request(ad_request)
  #   uri = URI('http://www.onlineautoinsurance.com/get-quotes/async.php')
  #
  #   http = Net::HTTP.new(uri.host, 80)
  #   http.use_ssl = false
  #
  #   request = Net::HTTP::Post.new(uri.path)
  #   request.content_type = 'application/x-www-form-urlencoded'
  #   request.body = URI.encode_www_form({:option => '2014', :type => 'year'})
  #
  #   http.request(request)
  # end

  # def self.send_request(zip, state)
  #   uri = URI('http://www.quotensure.com/sample_ads.txt')
  #
  #   http = Net::HTTP.new(uri.host, 80)
  #   http.use_ssl = false
  #
  #   request = Net::HTTP::Get.new(uri.path)
  #   request.content_type = 'text/xml'
  #   request.body = URI.encode_www_form({:zip => zip, :state => state})
  #
  #   http.request(request)
  # end

  # def self.parse_response(response)
  #   xml = Nokogiri::XML(response.body)
  #   xml.xpath('//samples/sample').map do |i|
  #     Ad.new({
  #                :header => i.xpath('headline').text,
  #                :content => i.xpath('detail').text,
  #                :logo_link => i.xpath('logo').text,
  #                :click_link => i.xpath('click-link').text,
  #                :display_link => i.xpath('display-link').text
  #            })
  #   end
  # end
end
