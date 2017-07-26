class CreateAdGroups < ActiveRecord::Migration
  def change
    create_table :ad_groups do |t|
      t.integer :campaign_gid, :limit => 8
      t.integer :gid, :limit => 8
      t.string :name
      t.string :status

      t.timestamps null: false
    end
    add_index :ad_groups, :gid, :unique => true
    add_index :ad_groups, :campaign_gid
  end
end
