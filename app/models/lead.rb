class Lead < ActiveRecord::Base
  include CommonScopes
  include MossHelper
  include ReviHelper
  include AnalyticsHelper
  enum status: [:_received, :_saved, :_processing, :_processed, :_sold, :_rejected]

  belongs_to :visit

  has_many :vehicles
  accepts_nested_attributes_for :vehicles, :reject_if => :all_blank
  has_many :drivers
  accepts_nested_attributes_for :drivers, :reject_if => :all_blank
  has_one :contact
  accepts_nested_attributes_for :contact, :reject_if => :all_blank
  has_one :policy
  accepts_nested_attributes_for :policy, :reject_if => :all_blank
  has_many :incidents
  accepts_nested_attributes_for :incidents, :reject_if => :all_blank

  validates :visit_id, presence: true

  before_save :set_token, :clean_incident
  after_save :assign_vehicle_to_driver


  def init_components
    self.vehicles.build
    self.drivers.build
    self.build_contact
    self.build_policy
  end

  def self.has_incident_pairs
    [['Yes', true], ['No', false]]
  end

  def self.has_incident_selected_id
    false
  end

  def send_error_notification(message)
    ErrorMailer.error_email('Lead Error', self.errors.full_messages.to_s + 'params: '+ message).deliver
  end

  def sell
    # self._processing!
    # self.send_to_moss
    # self.save
    #
    # Lead.send_lead_event(self, 'Moss')
    #
    # self.update_revenue
    #
    # self.update_lead_revenue
    #
    # if self._rejected? && self.error_code != 'UNABLE_TO_MONETIZE'
    #   ErrorMailer.error_email('Lead Rejected: ', 'id: ' + self.id.to_s + "\n" + self.response.to_s).deliver
    # end

    self._processing!
    self.send_to_revi
    self.save

    Lead.send_lead_event(self, 'Revi')

    if self._rejected? && !self.error_code.blank?
      ErrorMailer.error_email('Lead Rejected: ', 'id: ' + self.id.to_s + "\n" + self.response.to_s).deliver
    end
  end

  def self.resell(start_id, end_id)
    leads = Lead.where('id Between ? and ?', start_id, end_id).all
    leads.each do |lead|
      lead.delay.sell
    end
  end

  def update_revi_revenue(result, payout)
    self.payout = payout
    if result == 'Sold'
      self._sold!
      self.update_revenue
      self.update_lead_revenue
    else
      self._rejected!
    end
    self.save
  end

  protected

  def set_token
    if self.token.nil?
      self.token=SecureRandom.uuid
    end
  end

  def clean_incident
    if self.has_incident
      # Do Nothing
    else
      self.incidents.delete_all
    end
  end

  def assign_vehicle_to_driver
    self.drivers.each_with_index do |d, i|
      if i < self.vehicles.count
        d.vehicle_id = self.vehicles[i].id
      else
        d.vehicle_id = self.vehicles.last.id
      end
      d.save
    end
    self.vehicles.each_with_index do |v, i|
      v.rid = i+1
      v.save
    end
  end

  def update_revenue
    if self._sold?
      revenue = Revenue.new(:r_type => '_lead', :source => self.source, :token => self.token, :amount => payout)
      revenue.save
    end
  end

  def update_lead_revenue
    lead_revenue = LeadRevenue.new(:source => self.source, :token => self.token)

    if self._rejected?
      lead_revenue.amount = 0.0
      lead_revenue.status = 'Rejected'
    elsif self._sold?
      lead_revenue.amount = self.payout
      lead_revenue.status = 'Accepted'
    end

    lead_revenue.save
  end

  def send_to_moss
    self.source = 'Moss'

    # uri = URI('http://buyer-calmadness.herokuapp.com/moss_leads')
    uri = URI('https://services.mossexchange.com/leadhandler/lead.aspx')

    http = Net::HTTP.new(uri.host, 80)
    http.use_ssl = false

    request = Net::HTTP::Post.new(uri.path)
    request.content_type = 'application/x-www-form-urlencoded'
    request.body = URI.encode_www_form({:ProductType => 'auto', :RequestType => 'directpost', :LeadData => self.to_moss_xml})

    response = http.request(request)

    self.response_header = response.header.to_s
    self.response = response.body.to_s
    self.parse_moss_response
  end

  def parse_moss_response
    status = Hash.from_xml(self.response)['MSAResponse']['Status']
    if status == 'Rejected'
      self._rejected!
      self.error_code = Hash.from_xml(self.response)['MSAResponse']['ErrorCode']
    elsif status=='Accepted'
      self._sold!
      self.payout = Hash.from_xml(self.response)['MSAResponse']['Payout']
    else
      self._processed!
    end
  end

  def to_moss_xml(options = {})
    require 'builder'
    options[:indent] ||= 2
    xml = options[:builder] ||= ::Builder::XmlMarkup.new(indent: options[:indent])
    # xml.instruct! unless options[:skip_instruct]

    xml.MSALead do
      # LeadSourceData
      xml.LeadSourceData do
        xml.tag!(:AffiliateLogin, 'CD14144')
        xml.tag!(:AffiliatePassword, 'P2adru')
        xml.tag!(:ConsumerIP, self.visit.ip)
        xml.tag!(:AffiliateLeadID, self.token)
        xml.tag!(:ConsumerLeadID, self.leadid_token)
        xml.tag!(:LeadCreationDate, Time.now.strftime("%Y-%m-%dT%I:%M:%S"))
      end
      # LeadData
      xml.LeadData do
        # ContactDetails
        xml.ContactDetails do
          xml.tag!(:FirstName, self.drivers.primary_driver.first.first_name)
          xml.tag!(:LastName, self.drivers.primary_driver.first.last_name)
          xml.tag!(:StreetAddress, self.contact.address1)
          xml.tag!(:City, self.contact.city)
          xml.tag!(:State, self.contact.state)
          xml.tag!(:ZIPCode, self.contact.zip)
          xml.tag!(:Email, self.contact.email)
          xml.PhoneNumbers do
            xml.PhoneNumber(:Type => 'Cell') do
              xml.tag!(:Number, self.contact.phone)
            end
          end
          xml.ResidenceStatus(self.contact.residence_status.moss, :YearsAt => self.contact.residence_year.moss, :MonthsAt => self.contact.residence_month.moss)
          if self.leadid_tcpa_disclosure?
            xml.tag!(:TCPAOptIn, 'Yes')
          end
        end
        # InsurancePolicy
        xml.InsurancePolicy do
          xml.NewPolicy do
            xml.tag!(:RequestedCoverage, self.policy.request_coverage.moss)
          end
          xml.PriorPolicy(:CurrentlyInsured => self.policy.is_insured.moss) do
            if self.policy.is_insured?
              xml.InsuranceCompany(self.policy.company.moss_code, :YearsWith => self.policy.continuous_year.moss, :MonthsWith => self.policy.months_with_company)
              xml.tag!(:YearsContinuous, self.policy.continuous_year.moss)
              xml.tag!(:MonthsContinuous, self.policy.continuous_month)
              xml.tag!(:PolicyExpirationDate, self.policy.expiration_date)
            end
          end
        end
        # AutoLead
        xml.AutoLead do
          # Vehicles
          xml.Vehicles do
            self.vehicles.each do |v|
              next if v.rid > 3
              xml.Vehicle(:VehicleID => v.rid, :Ownership => v.owner_type.moss) do
                xml.VehicleData do
                  xml.tag!(:VehYear, v.year.name)
                  xml.tag!(:VehMake, v.make.name)
                  xml.tag!(:VehModel, v.model.name)
                  xml.tag!(:VehSubmodel, '')
                end
                xml.VehUse(v.vehicle_use.moss, :AnnualMiles => v.annual_mileage.moss, :WeeklyCommuteDays => v.commute_day.moss, :DailyCommuteMiles => v.get_daily_mileage)
                xml.tag!(:ComphrensiveDeductible, v.comp_deduct.moss)
                xml.tag!(:CollisionDeductible, v.coll_deduct.moss)
                xml.tag!(:GarageType, v.garage_type.moss)
              end
            end
          end
          # Drivers
          xml.Drivers do
            self.drivers.each_with_index do |d, i|
              next if i > 3
              xml.Driver(:DriverID => i+1) do
                xml.PersonalInfo(:MaritalStatus => d.marital_status.moss, :RelationshipToApplicant => d.relationship.moss, :Gender => d.gender.moss) do
                  xml.tag!(:FirstName, d.first_name)
                  xml.tag!(:LastName, d.last_name)
                  xml.tag!(:BirthDate, d.birthday)
                  xml.tag!(:Occupation, d.occupation.moss)
                  xml.tag!(:MilitaryExperience, 'No Military Experience')
                  xml.Education(d.education.moss, :GoodStudentDiscount => Lead.bool_to_s(d.is_good_gpa))
                  xml.CreditRating(d.credit.moss, :Bankruptcy => Lead.bool_to_s(d.is_bankruptcy))
                end
                xml.tag!(:PrimaryVehicle, d.vehicle.rid)
                xml.DriversLicense(:LicenseEverSuspendedRevoked => d.lic_status.moss) do
                  xml.tag!(:State, self.contact.state)
                  xml.tag!(:LicensedAge, d.age_lic.moss)
                end
                xml.DrivingRecord(:SR22Required => d.is_sr22.moss, :DriverTraining => 'No') do
                  d.prepare_incidents
                  if d.has_dui
                    xml.DUIs do
                      d.duis.each do |dui|
                        xml.DUI(:Year => dui.year, :Month => format('%02d', dui.month)) do
                          xml.tag!(:State, dui.state)
                        end
                      end
                    end
                  end
                  if d.has_accident
                    xml.Accidents do
                      d.accidents.each do |accident|
                        xml.Accident(:Year => accident.year, :Month => format('%02d', accident.month)) do
                          xml.tag!(:Description, accident.accident_type.moss)
                          xml.tag!(:AtFault, Lead.bool_to_s(accident.at_fault))
                          xml.tag!(:WhatDamaged, accident.damage_type.moss)
                          xml.tag!(:InsurancePaidAmount, accident.paid_amount)
                        end
                      end
                    end
                  end
                  if d.has_claim
                    xml.Claims do
                      d.claims.each do |claim|
                        xml.Claim(:Year => claim.year, :Month => format('%02d', claim.month)) do
                          xml.tag!(:Description, claim.claim_type.moss)
                          xml.tag!(:AtFault, Lead.bool_to_s(claim.at_fault))
                          xml.tag!(:WhatDamaged, claim.damage_type.moss)
                          xml.tag!(:InsurancePaidAmount, claim.paid_amount)
                        end
                      end
                    end
                  end
                  if d.has_ticket
                    xml.Tickets do
                      d.tickets.each do |ticket|
                        xml.Ticket(:Year => ticket.year, :Month => format('%02d', ticket.month)) do
                          xml.tag!(:Description, ticket.ticket_type.moss)
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  def send_to_revi
    self.source = 'Revi'

    uri = URI('http://lxpbase.stagingrevi.com/lxpbase')

    http = Net::HTTP.new(uri.host, 80)
    http.use_ssl = false

    request = Net::HTTP::Post.new(uri.path)
    request.content_type = 'text/xml'
    request.body = self.to_revi_xml

    response = http.request(request)

    self.response_header = response.header.to_s
    self.response = response.body.to_s
    parse_revi_response
  end

  def parse_revi_response
    result = Hash.from_xml(self.response)['Response']['Result']
    if result['Value'] == 'BaeOK'
      self.buyer_token = result['TransactionId']
      self._processed!
    elsif result['Value']=='BaeNOK'
      self.error_code = result['Error']
      self._rejected!
    else
      self._processed!
    end
  end

  def to_revi_xml(options = {})
    require 'builder'
    options[:indent] ||= 2
    xml = options[:builder] ||= ::Builder::XmlMarkup.new(indent: options[:indent])
    # xml.instruct! unless options[:skip_instruct]

    xml.LeadData(:Target => 'Lead.Insert', :Partner => 'alphardlabs@api.com', :Password => '@lphardLab$', :RequestTime => Time.now.strftime("%Y-%m-%d %I:%M:%S")) do
      xml.AffiliateData(:Id=>"4783", :OfferId=>"172", :SubId=>"0", :Sub2Id=>self.token, :Source=>"Google", :VerifyAddress=>"false", :RespondOnNoSale=>"true", :SellResponseURL=>"http://www.quotensure.com/revi_media", :LeadId=>self.leadid_token)
      xml.ContactData do
        xml.tag!(:FirstName, self.drivers.primary_driver.first.first_name)
        xml.tag!(:LastName, self.drivers.primary_driver.first.last_name)
        xml.tag!(:Address, self.contact.address1)
        xml.tag!(:City, self.contact.city)
        xml.tag!(:State, self.contact.state)
        xml.tag!(:ZIPCode, self.contact.zip)
        xml.tag!(:EmailAddress, self.contact.email)
        xml.tag!(:PhoneNumber, self.contact.phone)
        xml.tag!(:DayPhoneNumber, self.contact.phone)
        xml.tag!(:IPAddress, self.visit.ip)
        xml.tag!(:ResidenceType, self.contact.residence_status.revi)
        xml.tag!(:YearsAtResidence, self.contact.residence_year.revi)
        xml.tag!(:MonthsAtResidence, self.contact.residence_month.revi)
      end
      xml.QuoteRequest(:QuoteType=>'Auto') do
        # Drivers
        xml.Drivers do
          self.drivers.each_with_index do |d, i|
            next if i > 3
            xml.Driver do
              xml.tag!(:FirstName, d.first_name)
              xml.tag!(:LastName, d.last_name)
              xml.tag!(:BirthDate, d.birthday)
              xml.tag!(:MaritalStatus, d.marital_status.revi)
              xml.tag!(:RelationshipToApplicant, d.relationship.revi)
              xml.tag!(:Gender, d.gender.revi)
              xml.tag!(:LicenseState, self.contact.state)
              xml.tag!(:AgeLicensed, d.age_lic.revi)
              xml.tag!(:LicenseStatus, d.lic_status.revi)
              xml.tag!(:LicenseEverSuspendedRevoked, Lead.lic_ever_suspended(d.lic_status.name))
              xml.tag!(:Occupation, d.occupation.revi)
              xml.tag!(:YearsAtEmployer, '3')
              xml.tag!(:Education, d.education.revi)
              xml.tag!(:RequiresSR22Filing, d.is_sr22.revi)
              xml.tag!(:CreditRating, d.credit.revi)
              xml.Incidents do
                d.prepare_incidents
                if d.has_dui
                  xml.MajorViolations do
                    d.duis.each do |dui|
                      xml.MajorViolation do
                        xml.tag!(:Date, "#{dui.year}-#{format('%02d', dui.month)}-01")
                        xml.tag!(:Description, 'DUI/DWAI')
                        xml.tag!(:State, dui.state)
                      end
                    end
                  end
                end
                if d.has_accident
                  xml.Accidents do
                    d.accidents.each do |accident|
                      xml.Accident(:Year => accident.year, :Month => format('%02d', accident.month)) do
                        xml.tag!(:AccidentDate, "#{accident.year}-#{format('%02d', accident.month)}-01")
                        xml.tag!(:Description, accident.accident_type.revi)
                        xml.tag!(:AtFault, Lead.bool_to_s(accident.at_fault))
                        xml.tag!(:Damage, accident.damage_type.revi)
                        xml.tag!(:Amount, accident.paid_amount)
                      end
                    end
                  end
                end
                if d.has_claim
                  xml.Claims do
                    d.claims.each do |claim|
                      xml.Claim do
                        xml.tag!(:ClaimDate, "#{claim.year}-#{format('%02d', claim.month)}-01")
                        xml.tag!(:Description, claim.claim_type.revi)
                        xml.tag!(:Damage, claim.damage_type.revi)
                        xml.tag!(:PaidAmount, claim.paid_amount)
                      end
                    end
                  end
                end
                if d.has_ticket
                  xml.Violations do
                    d.tickets.each do |ticket|
                      xml.Violation do
                        xml.tag!(:Date, "#{ticket.year}-#{format('%02d', ticket.month)}-01")
                        xml.tag!(:Description, ticket.ticket_type.moss)
                      end
                    end
                  end
                end
              end
            end
          end
        end
        xml.Vehicles do
          self.vehicles.each do |v|
            next if v.rid > 3
            xml.Vehicle do
              xml.tag!(:Year, v.year.name)
              xml.tag!(:Make, v.make.name)
              xml.tag!(:Model, v.model.name)
              xml.tag!(:Garage, v.garage_type.revi)
              xml.tag!(:Ownership, v.owner_type.revi)
              xml.tag!(:PrimaryUse, v.vehicle_use.revi)
              xml.tag!(:AnnualMiles, v.annual_mileage.revi)
              xml.tag!(:WeeklyCommuteDays, v.commute_day.revi)
              xml.tag!(:OneWayDistance, Lead.one_way_distance(v.get_daily_mileage/2.0))
              xml.tag!(:ComphrensiveDeductible, v.comp_deduct.revi)
              xml.tag!(:CollisionDeductible, v.coll_deduct.revi)
            end
          end
        end
        # InsurancePolicy
        xml.Insurance do
          xml.CurrentPolicy do
            if self.policy.is_insured?
              xml.tag!(:InsuranceCompany, self.policy.company.revi)
              xml.tag!(:InsuredSince, self.policy.expiration_date - self.policy.continuous_year.revi.to_i.years)
              xml.tag!(:ExpirationDate, self.policy.expiration_date)
            else
              xml.tag!(:InsuranceCompany, 'Currently not insured')
            end
          end
          xml.RequestedPolicy do
            xml.tag!(:CoverageType, self.policy.request_coverage.revi)
            xml.tag!(:BodilyInjury, Lead.bodily_injury(self.policy.request_coverage.name))
            xml.tag!(:PropertyDamage, Lead.property_damage(self.policy.request_coverage.name))
          end
        end
      end
    end
  end

end
