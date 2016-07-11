class MessagesController < ApplicationController
  include MailgunDev
  before_action :set_message, only: [:show]
  before_action :set_campaigns, only: [:new, :create]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to root_path, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET remote
  def detect_suppressions
    mail_dev = MailgunDev::Client.new
    result = mail_dev.check_bounce(params[:email])
    @status = result.code
  end

  # GET list of previously sent emails
  def emails
    mail_dev = MailgunDev::Client.new
    @emails = mail_dev.get_logs(params[:email])
  end

  private
    def set_campaigns
      mail_dev = MailgunDev::Client.new
      @campaigns = mail_dev.campaigns
    end

    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:subject, :email, :message, :campaign_id)
    end
end
