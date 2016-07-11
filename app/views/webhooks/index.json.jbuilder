json.array!(@webhooks) do |webhook|
  json.extract! webhook, :id, :event, :recipient, :domain, :campaign_id, :user_agent
  json.url webhook_url(webhook, format: :json)
end
