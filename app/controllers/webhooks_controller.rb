class WebhooksController < ApplicationController
  before_action :set_webhook, only: [:destroy]

  # GET /webhooks
  # GET /webhooks.json
  def index
    @webhooks = Webhook.all
  end

  # GET /webhooks/new
  def new
    @webhook = Webhook.new
  end

  # POST /webhooks
  # POST /webhooks.json
  def create
    puts params
    @webhook = Webhook.new(event: params[:event], recipient: params[:recipient],
                           domain: params[:domain], campaign_id:params[:campaign_id], user_agent: params['user-agent'])
    respond_to do |format|
      if @webhook.save
        format.html { render nothing: true }
      else
        format.html { render nothing: true  }
      end
    end
  end


  # DELETE /webhooks/1
  # DELETE /webhooks/1.json
  def destroy
    @webhook.destroy
    respond_to do |format|
      format.html { redirect_to webhooks_url, notice: 'Webhook was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_webhook
      @webhook = Webhook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def webhook_params
      params.require(:webhook).permit(:event, :recipient, :domain, :campaign_id, :user_agent)
    end
end
