
count = 0.0
error_zip_city_count = 0.0
error_ip_state_count = 0.0

Lead.all.each do |lead|
  if lead.contact.zip.present?
    zip_code = ZipCode.find_by_zip(lead.contact.zip)
    true_state = zip_code.state
    true_city = zip_code.city

    ip2location1 = IpToLocation.find_by_ip(lead.visit.ip)
    ip2location2 = IpToLocation.find_by_zip_code(lead.contact.zip)

    if ip2location1.nil?
      ip_state = ''
    else
      ip_state = ip2location1.state_abbr
    end

    if ip2location2.nil?
      zip_city = ''
    else
      zip_city = ip2location2.city_name
    end

    count += 1.0
    if true_state != ip_state
      error_ip_state_count += 1.0
      puts("#{lead.id}, true state: #{true_state}, ip state: #{ip_state}")
    end

    if true_city != zip_city
      error_zip_city_count += 1.0
      puts("#{lead.id}, true city: #{true_city}, ip city: #{zip_city}")
    end
  end
end

puts ("error ip state ratio: #{error_ip_state_count/count * 100.0} %")
puts ("error zip city ratio: #{error_zip_city_count/count * 100.0} %")