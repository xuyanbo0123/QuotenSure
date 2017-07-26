

ad_array = Array.new
Ad.all.each do |ad|
  if ad.created_at > 10.days.ago
    unless ad_array.include?(ad.display_link)
      ad_array.push(ad.display_link)
    end
  end
end

ad_array.each do |link|
  puts link+"\n"
end

# www.LibertyMutual.com
# www.Progressive.com
# www.AAA.com
# mercuryinsurance.com
# www.compare.com
# www.esurance.com/Michigan
# www.esurance.com/Utah
# www.prac.com
# www.PlymouthRockNJ.com
# www.esurance.com
# www.elephant.com
# www.NJTeachersQuote.net
# www.GetMyInsurance.com
# www.AARP.TheHartford.com
# www.Allstate.com
# www.esurance.com/Minnesota
# www.21st.com
# www.esurance.com/Iowa
# www.esurance.com/Oregon
# www.Compare.com
# www.esurance.com/South Carolina
# www.epiqagency.com
# www.esurance.com/Florida
# www.esurance.com/Tennessee
# www.esurance.com/Ohio
# www.esurance.com/Oklahoma
# www.esurance.com/Indiana
# www.esurance.com/
# www.esurance.com/Mississippi
# www.esurance.com/Alabama
# www.esurance.com/Missouri
# www.esurance.com/Wisconsin