ads = Ad.where('created_at Between ? and ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
ad_requests = AdRequest.where('created_at Between ? and ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
r = (ads.count*1.0)/(ad_requests.count*1.0)
puts('today ratio: ' + r.to_s)

(1..20).each do |i|
  ads = Ad.where('created_at Between ? and ?', i.days.ago.beginning_of_day, i.days.ago.end_of_day).all
  ad_requests = AdRequest.where('created_at Between ? and ?', i.days.ago.beginning_of_day, i.days.ago.end_of_day).all
  r = (ads.count*1.0)/(ad_requests.count*1.0)
  puts("#{i} day before today ratio: #{r}")
end