class Message < ActiveRecord::Base
  include MailgunDev

  validates :subject, :email, :message, :campaign_id, presence: true

  after_create :send_email

  def send_email
    mail_dev = MailgunDev::Client.new
    mail_dev.send_email("carlosandrestorres28@gmail.com", subject, message, campaign_id)
  end
end
