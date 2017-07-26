total_count = 0.0
sold_count = 0.0
reject_count = 0.0
unable_monetize_count = 0.0
invalid_lead_count = 0.0
other_reject_count = 0.0

under_25_count_sold = 0.0
under_25_count_reject = 0.0
has_incident_sold = 0.0
has_incident_reject = 0.0
married_sold = 0.0
married_reject = 0.0
under_bachelor_sold = 0.0
under_bachelor_reject = 0.0
poor_credit_sold = 0.0
poor_credit_reject = 0.0
non_own_sold = 0.0
non_own_reject = 0.0

poor_count_sold = 0.0
poor_count_reject = 0.0
state_array_sold =  Array.new
state_array_reject =  Array.new
state_array = Array.new

Lead.all.each do |lead|
  if lead.response.present? && lead.id > 30
    response_xml = lead.response.to_s[/<MSAResponse.+/]
    total_count += 1.0
    status = Hash.from_xml(response_xml)['MSAResponse']['Status']
    if status == 'Accepted'
      sold_count += 1.0

      # state
      if state_array_sold.include?(lead.contact.state)
        state_array_sold[state_array_sold.index(lead.contact.state) + 1] += 1
      else
        state_array_sold.push(lead.contact.state)
        state_array_sold.push(1)
      end
      #
      if state_array.include?(lead.contact.state)
        state_array[state_array.index(lead.contact.state) + 1] += 1.0
      else
        state_array.push(lead.contact.state)
        state_array.push(0.0)
        state_array.push(0.0)
        state_array.push(0.0)
        state_array[state_array.index(lead.contact.state) + 1] += 1.0
      end

      # age <= 25
      if lead.drivers.first.birthday.year >= 1990
        under_25_count_sold += 1.0
      end
      # has_incident
      if lead.has_incident?
        has_incident_sold += 1.0
      end
      # married
      if lead.drivers.first.marital_status.name == '_MARRIED'
        married_sold += 1.0
      end
      # under bachelor
      if lead.drivers.first.education_id < 6
        under_bachelor_sold += 1.0
      end
      # poor credit
      if lead.drivers.first.credit_id > 2
        poor_credit_sold += 1.0
      end
      #  non own
      if lead.contact.residence_status.name != '_OWN'
        non_own_sold += 1.0
      end

      driver = lead.drivers.first
      if driver.birthday.year >= 1990 || driver.credit_id >= 2 || driver.marital_status_id != 2 || driver.education_id < 6 || lead.contact.residence_status_id != 1
        poor_count_sold += 1.0
      end

    elsif status == 'Rejected'
      reject_count += 1.0

      error_code = Hash.from_xml(response_xml)['MSAResponse']['ErrorCode']
      if error_code == 'UNABLE_TO_MONETIZE'
        unable_monetize_count += 1.0
        # state
        if state_array_reject.include?(lead.contact.state)
          state_array_reject[state_array_reject.index(lead.contact.state) + 1] += 1
        else
          state_array_reject.push(lead.contact.state)
          state_array_reject.push(1)
        end
        #
        if state_array.include?(lead.contact.state)
          state_array[state_array.index(lead.contact.state) + 2] += 1.0
        else
          state_array.push(lead.contact.state)
          state_array.push(0.0)
          state_array.push(0.0)
          state_array.push(0.0)
          state_array[state_array.index(lead.contact.state) + 2] += 1.0
        end

        # age <= 25
        if lead.drivers.first.birthday.year >= 1990
          under_25_count_reject += 1.0
        end
        # has_incident
        if lead.has_incident?
          has_incident_reject += 1.0
        end
        # married
        if lead.drivers.first.marital_status.name == '_MARRIED'
          married_reject += 1.0
        end
        # under bachelor
        if lead.drivers.first.education_id < 6
          under_bachelor_reject += 1.0
        end
        # poor credit
        if lead.drivers.first.credit_id > 2
          poor_credit_reject += 1.0
        end
        #  non own
        if lead.contact.residence_status.name != '_OWN'
          non_own_reject += 1.0
        end

        driver = lead.drivers.first
        if driver.birthday.year >= 1990 || driver.credit_id >= 2 || driver.marital_status_id != 2 || driver.education_id < 6 || lead.contact.residence_status_id != 1
          poor_count_reject += 1.0
        end
      elsif error_code == 'INVALID_LEAD_DATA'
        invalid_lead_count += 1.0
      else
        other_reject_count += 1.0
      end
    end
  end
end

puts ("total lead: #{total_count}")
puts ("sold ratio: #{sold_count/total_count * 100.0} %")
puts ("reject ratio: #{reject_count/total_count * 100.0} %")
puts ("unable to monetize ratio: #{unable_monetize_count/total_count * 100.0} %")
puts ("invalid lead data ratio: #{invalid_lead_count/total_count * 100.0} %")
puts ("other reason reject ratio: #{other_reject_count/total_count * 100.0} %")
puts ("\n")
puts ("under 25 ratio in sold: #{under_25_count_sold/sold_count * 100.0} %")
puts ("under 25 ratio in unable to monetize: #{under_25_count_reject/unable_monetize_count * 100.0} %")
puts ("has incident in sold: #{has_incident_sold/sold_count * 100.0} %")
puts ("has incident in unable to monetize: #{has_incident_reject/unable_monetize_count * 100.0} %")
puts ("married in sold: #{married_sold/sold_count * 100.0} %")
puts ("married in unable to monetize: #{married_reject/unable_monetize_count * 100.0} %")
puts ("under bachelor in sold: #{under_bachelor_sold/sold_count * 100.0} %")
puts ("under bachelor in unable to monetize: #{under_bachelor_reject/unable_monetize_count * 100.0} %")
puts ("poor credit in sold: #{poor_credit_sold/sold_count * 100.0} %")
puts ("poor credit in unable to monetize: #{poor_credit_reject/unable_monetize_count * 100.0} %")
puts ("non home owner in sold: #{non_own_sold/sold_count * 100.0} %")
puts ("non home owner in unable to monetize: #{non_own_reject/unable_monetize_count * 100.0} %")

puts ("poor ratio in sold: #{poor_count_sold/sold_count * 100.0} %")
puts ("poor ratio in unable to monetize: #{poor_count_reject/unable_monetize_count * 100.0} %")
puts ("\n")
state_array.each_index do |i|
  if i % 4 == 0 && state_array[i+2] != 0
    state_array[i+3] = state_array[i+1]/(state_array[i+1] + state_array[i+2])

    # if state_array[i+1]+state_array[i+2]>32
    #   puts("#{state_array[i]}, #{state_array[i+1]}, #{state_array[i+2]}, #{state_array[i+3]}\n")
    # end

    if state_array[i+3]<0.5
      puts("#{state_array[i]}, #{state_array[i+1]}, #{state_array[i+2]}, #{state_array[i+3]}\n")
    end

  end
end
puts (state_array.to_s)
# puts (state_array_sold.to_s)
# puts (state_array_reject.to_s)
