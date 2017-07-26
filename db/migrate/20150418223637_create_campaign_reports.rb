class CreateCampaignReports < ActiveRecord::Migration
  def change
    create_table :campaign_reports do |t|
      t.date :day
      t.string :campaign
      t.integer :clicks
      t.integer :impressions
      t.integer :cost_cents
      t.decimal :avg_position, precision: 5, scale: 2

      t.timestamps
    end
  end
end
