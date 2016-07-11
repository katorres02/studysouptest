class CampaignsController < ApplicationController
  #include MailgunDev

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.all
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    #mail_gun = MailgunDev::Client.new
    #response = mail_gun.create_campaign(campaign_params[:name])
    @campaign = Campaign.new(campaign_params)
    #@campaign.mailgun_id = JSON.parse(response)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:name, :mailgun_id)
    end
end
