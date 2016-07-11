module MailgunDev
  class Client
    attr_reader :private_key, :domain_name, :from

    def initialize
      @private_key = ENV["PRIVATE_KEY_MAILGUN"]
      @domain_name = ENV["DOMAIN_NAME_MAILGUN"]
      @from        = ENV["FROM_MAILGUN"]
    end

    def send_email(email_to, subject, text, campaign_id)
      RestClient.post "https://api:#{@private_key}"\
      "#{@domain_name}/messages",
      :from => @from,
      #:to => "carlos <carlosandrestorres28@gmail.com>",
      :to => email_to,
      :subject => subject,
      :text => text,
      "o:campaign" => campaign_id,
      "o:tracking"=>"yes",
      "o:tracking-opens"=>"yes",
      "o:tracking-clicks"=>"yes"
    end

    def campaigns
      request = RestClient.get "https://api:#{@private_key}#{@domain_name}/campaigns"
      items = JSON.parse(request)['items']
      items.map { |campaign| [campaign['name'], campaign['id']] }
    end

    def create_campaign(name)
      RestClient.post "https://api:#{@private_key}#{@domain_name}/campaigns",
      :name => name
    end

    def check_bounce(email)
      RestClient.get("https://api:#{@private_key}#{@domain_name}/bounces"\
      "/#{email}"){|response, request, result| response }
    end

    def get_logs(email)
      request = RestClient.get "https://api:#{@private_key}#{@domain_name}/events",
      params: {
        recipient:  email
      }
      response = JSON.parse(request)['items']
      response.map { |message| message['message']['headers']}
    end
  end

end