class CreateWebhooks < ActiveRecord::Migration
  def change
    create_table :webhooks do |t|
      t.string :event
      t.string :recipient
      t.string :domain
      t.string :campaign_id
      t.string :user_agent

      t.timestamps null: false
    end
  end
end
