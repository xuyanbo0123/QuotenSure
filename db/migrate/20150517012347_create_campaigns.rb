class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :gid, :limit => 8
      t.string :name
      t.string :status
      t.integer :budget

      t.timestamps null: false
    end
    add_index :campaigns, :gid, :unique => true
  end
end
