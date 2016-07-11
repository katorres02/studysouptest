json.array!(@messages) do |message|
  json.extract! message, :id, :subject, :email, :message, :campaign_id
  json.url message_url(message, format: :json)
end
