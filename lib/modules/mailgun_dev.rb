module MailgunDev
  class Client
    attr_reader :private_key

    def initialize
      @private_key = "key-e9f56c927149acf55b4de412bb659efc"
    end

    def send_email(email_to, subject, text, campaign_id)
      RestClient.post "https://api:#{@private_key}"\
      "@api.mailgun.net/v3/sandbox3ba8b9ab95324c8fa1c53581f0d9b805.mailgun.org/messages",
      :from => "Mailgun Sandbox <postmaster@sandboxbddd8558c01a477095acb901296c3914.mailgun.org>",
      :to => "carlos <carlosandrestorres28@gmail.com>",
      :subject => subject,
      :text => text,
      "o:campaign" => campaign_id
    end

    def campaigns
      request = RestClient.get "https://api:#{@private_key}@api.mailgun.net/v3/sandbox3ba8b9ab95324c8fa1c53581f0d9b805.mailgun.org/campaigns"
      items = JSON.parse(request)['items']
      items.map { |campaign| [campaign['name'], campaign['id']] }
    end

    def create_campaign(name)
      RestClient.post "https://api:#{@private_key}@api.mailgun.net/v3/sandbox3ba8b9ab95324c8fa1c53581f0d9b805.mailgun.org/campaigns",
      :name => name
    end

    def check_bounce(email)
      RestClient.get("https://api:#{@private_key}@api.mailgun.net/v3/sandbox3ba8b9ab95324c8fa1c53581f0d9b805.mailgun.org/bounces"\
      "/#{email}"){|response, request, result| response }
    end

    def get_logs(email)
      request = RestClient.get "https://api:#{@private_key}@api.mailgun.net/v3/sandbox3ba8b9ab95324c8fa1c53581f0d9b805.mailgun.org/events",
      params: {
        recipient:  email
      }
      response = JSON.parse(request)['items']
      response.map { |message| message['message']['headers']}
    end
  end

end