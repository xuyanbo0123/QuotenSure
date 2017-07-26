require 'rubygems'
require 'net/http'
require 'active_support/core_ext/hash'

class CityStateLookup
  attr_accessor :zip, :city, :state

  def initialize(zip)
    @zip = zip
  end

  def get_xml
    "<CityStateLookupRequest USERID=\"686BRIGH2750\"><ZipCode ID=\"0\"><Zip5>#{@zip}</Zip5></ZipCode></CityStateLookupRequest>"
  end

  def get_data
    uri = URI.parse('http://production.shippingapis.com/ShippingAPI.dll')
    data = Net::HTTP.post_form(uri, {:API=>'CityStateLookup', :XML=>self.get_xml})
    @city = Hash.from_xml(data.body)['CityStateLookupResponse']['ZipCode']['City']
    @state = Hash.from_xml(data.body)['CityStateLookupResponse']['ZipCode']['State']
    self
  end

  def to_csv(outfile, error_file)
    if @city.nil? || @city.blank?
      puts @zip + " error"
      error_file.puts "#{@zip},#{@city},#{@state}"
    else
      puts @zip
      outfile.puts "#{@zip},#{@city},#{@state}"
    end
  end
end

i = 0

# file = File.open("usps_zips_#{i}.csv", 'a')
# error_file = File.open("error_zips_#{i}.csv", 'a')
#
# (20000*i..20000*(i+1)-1).each do |z|
#   if z > 4683
#     begin
#       CityStateLookup.new(z.to_s.rjust(5, '0')).get_data.to_csv(file, error_file)
#     rescue => e
#       sleep 2
#       CityStateLookup.new(z.to_s.rjust(5, '0')).get_data.to_csv(file, error_file)
#     end
#   end
# end
#
# error_file.close
# file.close

in_file = File.open("error_zips_#{i}.csv", 'r')
out_file = File.open("usps_zips_fix_#{i}.csv", 'a')
error_file = File.open("error_zips_fix_#{i}.csv", 'a')

in_file.each do |line|
  begin
    CityStateLookup.new(line[0..4]).get_data.to_csv(out_file, error_file)
  rescue => e
    sleep 2
    CityStateLookup.new(line[0..4]).get_data.to_csv(out_file, error_file)
  end
end

error_file.close
out_file.close
in_file.close