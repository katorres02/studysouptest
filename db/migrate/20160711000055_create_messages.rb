class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.string :email
      t.text :message
      t.string :campaign_id

      t.timestamps null: false
    end
  end
end
