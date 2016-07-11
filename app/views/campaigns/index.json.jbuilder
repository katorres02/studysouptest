json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :name, :mailgun_id
  json.url campaign_url(campaign, format: :json)
end
