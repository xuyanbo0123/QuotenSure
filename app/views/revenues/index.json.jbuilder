json.array!(@revenues) do |revenue|
  json.extract! revenue, :id, :r_type, :source, :token, :amount
  json.url revenue_url(revenue, format: :json)
end
