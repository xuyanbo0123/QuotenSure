json.array!(@brands) do |brand|
  json.extract! brand, :id, :name, :featured_review, :introduction
  json.url brand_url(brand, format: :json)
end
